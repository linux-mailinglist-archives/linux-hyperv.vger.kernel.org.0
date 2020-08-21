Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3DF524D879
	for <lists+linux-hyperv@lfdr.de>; Fri, 21 Aug 2020 17:25:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727116AbgHUPZw (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 21 Aug 2020 11:25:52 -0400
Received: from linux.microsoft.com ([13.77.154.182]:46832 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727091AbgHUPZu (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 21 Aug 2020 11:25:50 -0400
Received: from testvm-timer.0wqf5yk0ngwuzjntifuk1ppqse.cx.internal.cloudapp.net (unknown [40.65.222.102])
        by linux.microsoft.com (Postfix) with ESMTPSA id 95D9720B4908;
        Fri, 21 Aug 2020 08:25:49 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 95D9720B4908
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1598023550;
        bh=bC0FGrYXLPz3vW4zlcF+S6Fm1cVv02y/ELXHJG4PNlU=;
        h=From:To:Cc:Subject:Date:From;
        b=KyfDaFBeiutxMXxnG8OTPzazr2r4CrGFMykBI0bDTRQHM6v8ShOvfOyRbJ361nvWK
         KL+/ZFDyBQ/1nJKQpjN95BMsoiKXUU6kIfw63pLaMN8m0y/Wgbs3cADrhakUMPF/kp
         8wgp1VRYnMxsa/D8kZYI5IyFy/9ZWOLsTd8Nr1IA=
From:   Vineeth Pillai <viremana@linux.microsoft.com>
To:     Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>
Cc:     Vineeth Pillai <viremana@linux.microsoft.com>,
        "K . Y . Srinivasan" <kys@microsoft.com>,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] hv_utils: return error if host timesysnc update is stale
Date:   Fri, 21 Aug 2020 15:25:23 +0000
Message-Id: <20200821152523.99364-1-viremana@linux.microsoft.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

If for any reason, host timesync messages were not processed by
the guest, hv_ptp_gettime() returns a stale value and the
caller (clock_gettime, PTP ioctl etc) has no means to know this
now. Return an error so that the caller knows about this.

Signed-off-by: Vineeth Pillai <viremana@linux.microsoft.com>
---

 v2:
    - Fix warnings reported by Kernel test robot <lkp@intel.com>
    - s/pr_warn/pr_warn_once/

---
 drivers/hv/hv_util.c | 46 +++++++++++++++++++++++++++++++++-----------
 1 file changed, 35 insertions(+), 11 deletions(-)

diff --git a/drivers/hv/hv_util.c b/drivers/hv/hv_util.c
index 92ee0fe4c919..1f86e8d9b018 100644
--- a/drivers/hv/hv_util.c
+++ b/drivers/hv/hv_util.c
@@ -282,26 +282,52 @@ static struct {
 	spinlock_t			lock;
 } host_ts;
 
-static struct timespec64 hv_get_adj_host_time(void)
+static inline u64 reftime_to_ns(u64 reftime)
 {
-	struct timespec64 ts;
-	u64 newtime, reftime;
+	return (reftime - WLTIMEDELTA) * 100;
+}
+
+/*
+ * Hard coded threshold for host timesync delay: 600 seconds
+ */
+static const u64 HOST_TIMESYNC_DELAY_THRESH = 600 * (u64)NSEC_PER_SEC;
+
+static int hv_get_adj_host_time(struct timespec64 *ts)
+{
+	u64 newtime, reftime, timediff_adj;
 	unsigned long flags;
+	int ret = 0;
 
 	spin_lock_irqsave(&host_ts.lock, flags);
 	reftime = hv_read_reference_counter();
-	newtime = host_ts.host_time + (reftime - host_ts.ref_time);
-	ts = ns_to_timespec64((newtime - WLTIMEDELTA) * 100);
+
+	/*
+	 * We need to let the caller know that last update from host
+	 * is older than the max allowable threshold. clock_gettime()
+	 * and PTP ioctl do not have a documented error that we could
+	 * return for this specific case. Use ESTALE to report this.
+	 */
+	timediff_adj = reftime - host_ts.ref_time;
+	if (timediff_adj * 100 > HOST_TIMESYNC_DELAY_THRESH) {
+		pr_warn_once("TIMESYNC IC: Stale time stamp, %llu nsecs old\n",
+			     (timediff_adj * 100));
+		ret = -ESTALE;
+	}
+
+	newtime = host_ts.host_time + timediff_adj;
+	*ts = ns_to_timespec64(reftime_to_ns(newtime));
 	spin_unlock_irqrestore(&host_ts.lock, flags);
 
-	return ts;
+	return ret;
 }
 
 static void hv_set_host_time(struct work_struct *work)
 {
-	struct timespec64 ts = hv_get_adj_host_time();
 
-	do_settimeofday64(&ts);
+	struct timespec64 ts;
+
+	if (!hv_get_adj_host_time(&ts))
+		do_settimeofday64(&ts);
 }
 
 /*
@@ -622,9 +648,7 @@ static int hv_ptp_adjtime(struct ptp_clock_info *ptp, s64 delta)
 
 static int hv_ptp_gettime(struct ptp_clock_info *info, struct timespec64 *ts)
 {
-	*ts = hv_get_adj_host_time();
-
-	return 0;
+	return hv_get_adj_host_time(ts);
 }
 
 static struct ptp_clock_info ptp_hyperv_info = {

base-commit: 49971e6bad2da980686368baa34039907f62b516
-- 
2.17.1

