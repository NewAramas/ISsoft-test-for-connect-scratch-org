/**
 * Created by mryzhkouskaya on 19.11.2019.
 */
({
    doInit: function (component) {
        var visualforceDomain = "https://" + component.get("v.visualforceDomain");
        /**
         * Adding a new event listner on window object
         * to listen for message event
         **/
        window.addEventListener("message", function (event) {
            console.log('in component listener');
            if (visualforceDomain.indexOf(event.origin) === -1) {
                // Not the expected origin: reject message!
                console.error('Discarding Message | Message received from invalid domain: ', event.origin);
                return;
            }
            console.log('Lightning Gets: ', event.data);
            document.querySelector('#allMessages').innerHTML += '<p>' + event.data + '</p>';

        }, false);
    },


    /**
     * This function will be sending the data to visualforce page's window
     * object using postMessage function
     * */
    sendToVF: function (component, event, helper) {
        console.log('Lightning Sends: ', component.get("v.message"));
        var visualforceDomain = 'https://' + component.get('v.visualforceDomain');
        var message = component.get("v.message");

        var vfWindow = component.find("vfFrame").getElement().contentWindow;
        vfWindow.postMessage(message, visualforceDomain);

        component.set("v.message", "");
    }
});