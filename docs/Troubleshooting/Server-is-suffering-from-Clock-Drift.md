It is possible when you receive the Standard Daily or the Enterprise Daily report, and you encounter the warning message “This server is suffering from clock drift!”.

The check for clock drift is done every one minute, and if the FusionReactor clock differs from the clock on the server then this is tracked as a clock drift. It is possible that the clocks on the server or FusionReactor have become unsynchronized and therefore, you will see the warning of clock drift in the Standard Daily and Enterprise Daily reports.

Unfortunately, there is no straight forward fix to ensuring the clocks are synchronized. However, If you are consistently seeing this warning on the reports, you should consider checking the clock settings for you system. You could check the clock settings by the use of a network time protocol such as NTP.

!!! info "Learn more"
    [NTP](https://help.ubuntu.com/lts/serverguide/NTP.html)<br>
    [technet.microsoft.com](https://technet.microsoft.com/en-us/library/cc773263%28v=ws.10%29.aspx)

Alternatively, if you are setting the clocks manually, you could change the Standard Daily and Enterprise Daily report send time to ensure that the clocks are synchronized correctly before sending the report.


