Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58AD935DCCD
	for <lists+linux-hyperv@lfdr.de>; Tue, 13 Apr 2021 12:50:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237060AbhDMKus (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 13 Apr 2021 06:50:48 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:45060 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237097AbhDMKur (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 13 Apr 2021 06:50:47 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 13DAiYdB004879;
        Tue, 13 Apr 2021 10:50:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2020-01-29;
 bh=lLdNvK4ftLKel0hXn6PRPGezW59y7vBAnkI9NXgza4o=;
 b=YZGJ6g1id2aRxzhK2kOgZ7XnXC3SMarLcVa/mIC6XkGuWq6dV7EoSf0rjr5qZsZl8Wmh
 e0dAO74GvaN7rthBff3oIJOs0YRXuwS8tMJj8hEttYk0Am/Q1G5E0KyM1nJftpIyR40i
 Nl1hr5pbtR79E/I5am0saTEFZm+AVeFLowRUlktfnTIqj9I8kw5qUGoVeWxUMj7D2ZLN
 dnI5mlmYNisv1yni/fr9Gr7HY5ob0YSVJBEdZGVMnxgCaSDuA1H26onQ0T4sNs3p9m/p
 dZ494ho68jXvwV57JS4iIoXudyy4Lm/0UluTZoM+cijPsV07iUyXEHF0liUyoJC1O75F QQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 37u3ymek8d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 13 Apr 2021 10:50:24 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 13DAoM8S003839;
        Tue, 13 Apr 2021 10:50:23 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3030.oracle.com with ESMTP id 37unxwp7s3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 13 Apr 2021 10:50:22 +0000
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 13DAoDIg010852;
        Tue, 13 Apr 2021 10:50:13 GMT
Received: from mwanda (/102.36.221.92)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 13 Apr 2021 03:50:13 -0700
Date:   Tue, 13 Apr 2021 13:50:04 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     "K. Y. Srinivasan" <kys@microsoft.com>
Cc:     Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Dexuan Cui <decui@microsoft.com>, linux-hyperv@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] Drivers: hv: vmbus: Use after free in __vmbus_open()
Message-ID: <YHV3XLCot6xBS44r@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
X-Proofpoint-IMR: 1
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9952 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 malwarescore=0
 spamscore=0 adultscore=0 phishscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2104130075
X-Proofpoint-GUID: oWLg4Cl5UKUUuDGu--YtdMJoGkw-ow83
X-Proofpoint-ORIG-GUID: oWLg4Cl5UKUUuDGu--YtdMJoGkw-ow83
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9952 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 mlxlogscore=999 spamscore=0
 impostorscore=0 priorityscore=1501 lowpriorityscore=0 adultscore=0
 bulkscore=0 phishscore=0 suspectscore=0 malwarescore=0 clxscore=1011
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2104130074
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

The "open_info" variable is added to the &vmbus_connection.chn_msg_list,
but the error handling frees "open_info" without removing it from the
list.  This will result in a use after free.  First remove it from the
list, and then free it.

Fixes: 6f3d791f3006 ("Drivers: hv: vmbus: Fix rescind handling issues")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
From static analysis.  Untested etc.  There is almost certainly a good
reason to add it to the list before checking "newchannel->rescind" but I
don't know the code well enough to know what the reason is.

 drivers/hv/channel.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hv/channel.c b/drivers/hv/channel.c
index db30be8f9cce..1c5a418c1962 100644
--- a/drivers/hv/channel.c
+++ b/drivers/hv/channel.c
@@ -653,7 +653,7 @@ static int __vmbus_open(struct vmbus_channel *newchannel,
 
 	if (newchannel->rescind) {
 		err = -ENODEV;
-		goto error_free_info;
+		goto error_clean_msglist;
 	}
 
 	err = vmbus_post_msg(open_msg,
-- 
2.30.2

