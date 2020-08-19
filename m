Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D7FE24A521
	for <lists+linux-hyperv@lfdr.de>; Wed, 19 Aug 2020 19:45:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726735AbgHSRpu (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 19 Aug 2020 13:45:50 -0400
Received: from linux.microsoft.com ([13.77.154.182]:47436 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726585AbgHSRpr (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 19 Aug 2020 13:45:47 -0400
Received: from testvm-timer.0wqf5yk0ngwuzjntifuk1ppqse.cx.internal.cloudapp.net (unknown [40.65.222.102])
        by linux.microsoft.com (Postfix) with ESMTPSA id 5AF4A20B4908;
        Wed, 19 Aug 2020 10:45:46 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 5AF4A20B4908
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1597859147;
        bh=oJvVQrh4jnzYt7dEfXybXGswGytcooOTB3Khc1pg+FI=;
        h=From:To:Cc:Subject:Date:From;
        b=ca7C1VusOXy1L9HsrDB6vF01EVdJte1CPjAexezLrjCGftRbWPHc4Q4ya06L1wWO0
         +KPxzkCe1nUJsTMSxFWyy33ptlT+LKMBkr0RRaCnkgLl/ON12ORpTgudZHNrjPEuKx
         yEEzIti3qlHmofPm1X8qpyn0fjkxAZQ9Rvla8v6A=
From:   Vineeth Pillai <viremana@linux.microsoft.com>
To:     Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>
Cc:     Vineeth Pillai <viremana@linux.microsoft.com>,
        "K . Y . Srinivasan" <kys@microsoft.com>,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] hv_utils: return error if host timesysnc update is stale
Date:   Wed, 19 Aug 2020 17:45:27 +0000
Message-Id: <20200819174527.47156-1-viremana@linux.microsoft.com>
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
 drivers/hv/hv_util.c | 46 +++++++++++++++++++++++++++++++++-----------
 1 file changed, 35 insertions(+), 11 deletions(-)

diff --git a/drivers/hv/hv_util.c b/drivers/hv/hv_util.c
index 92ee0fe4c919..1357861fd8ae 100644
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
+const u64 HOST_TIMESYNC_DELAY_THRESH = 600 * NSEC_PER_SEC;
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
+		pr_warn("TIMESYNC IC: Stale time stamp, %llu nsecs old\n",
+			HOST_TIMESYNC_DELAY_THRESH);
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
-- 
2.17.1

