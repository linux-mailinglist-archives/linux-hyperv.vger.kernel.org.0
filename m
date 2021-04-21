Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1560E3668D3
	for <lists+linux-hyperv@lfdr.de>; Wed, 21 Apr 2021 12:07:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235351AbhDUKHc (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 21 Apr 2021 06:07:32 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:52856 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234768AbhDUKHc (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 21 Apr 2021 06:07:32 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 13LA3v6L157206;
        Wed, 21 Apr 2021 10:06:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2020-01-29;
 bh=rqZx3n1O9indxVMH5aRmvPsIj4nGHrjQy7QJ+DAfUA8=;
 b=UlEf3glD9GnQHWOabq08oRBICKH1rzlIQidEHobKGEj1WepgEOkoOJf6NW0fNfPL4byB
 cXlfvnOwmwCCILkOtwNfMC/ZkQUpiDQBqNiu3UGWsavIa1DIdiXrVc3RAYrzqfPZ9hR5
 BuSLwTNedYXgNIdn5OSqAyJbX759BGO5RRGawJlyjvo/LeRv8+nw77+6AvearsK17N7n
 ykLAODgGLNqLTwFvoIII9szmKiEnwTL1hL+bzWZ9XVx6QdaOy2SWisDn3KpAIWoVKN8M
 mmXq23yrde6eTTnCfnCAXkoIKHaHRp7bjezbp4wDIQXOPsP5+g5SXOS/ZW1759DyBZNu 3A== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 38022y16mk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 21 Apr 2021 10:06:57 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 13LA4pPE066401;
        Wed, 21 Apr 2021 10:06:56 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by userp3030.oracle.com with ESMTP id 3809m0c42v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 21 Apr 2021 10:06:56 +0000
Received: from userp3030.oracle.com (userp3030.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 13LA6uUr072957;
        Wed, 21 Apr 2021 10:06:56 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3030.oracle.com with ESMTP id 3809m0c42g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 21 Apr 2021 10:06:56 +0000
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 13LA6tmH003915;
        Wed, 21 Apr 2021 10:06:55 GMT
Received: from mwanda (/102.36.221.92)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 21 Apr 2021 03:06:54 -0700
Date:   Wed, 21 Apr 2021 13:06:49 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     decui@microsoft.com
Cc:     linux-hyperv@vger.kernel.org
Subject: [bug report] net: mana: Add a driver for Microsoft Azure Network
 Adapter (MANA)
Message-ID: <YH/5OQSEbCBvH9ju@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Proofpoint-ORIG-GUID: ifrNccH_lR7m1p5MFa76ssMISi2w1P2a
X-Proofpoint-GUID: ifrNccH_lR7m1p5MFa76ssMISi2w1P2a
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9960 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 lowpriorityscore=0
 spamscore=0 bulkscore=0 phishscore=0 clxscore=1015 impostorscore=0
 mlxlogscore=982 adultscore=0 malwarescore=0 mlxscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2104210077
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Hello Dexuan Cui,

The patch ca9c54d2d6a5: "net: mana: Add a driver for Microsoft Azure
Network Adapter (MANA)" from Apr 16, 2021, leads to the following
static checker warning:

	drivers/net/ethernet/microsoft/mana/hw_channel.c:292 mana_hwc_comp_event()
	warn: 'comp_read' unsigned <= 0

drivers/net/ethernet/microsoft/mana/hw_channel.c
   281  static void mana_hwc_comp_event(void *ctx, struct gdma_queue *q_self)
   282  {
   283          struct hwc_rx_oob comp_data = {};
   284          struct gdma_comp *completions;
   285          struct hwc_cq *hwc_cq = ctx;
   286          u32 comp_read, i;
                ^^^^^^^^^^^^^^^^^
These should be int.  I think GCC is encouraging everyone to use u32 but
the u32 type is really a terrible default type to use.  It causes a lot
of bugs.  This is my second or third signedness bug to deal with today.

Normally int is the best type to use.  In the kernel we're mostly using
small numbers where int is fine.  In filesystems etc then we're dealing
with huge numbers so u64 is the right type.  But it's a very narrow band
between 2 and 4 million where u32 is appropriate.

   287  
   288          WARN_ON_ONCE(hwc_cq->gdma_cq != q_self);
   289  
   290          completions = hwc_cq->comp_buf;
   291          comp_read = mana_gd_poll_cq(q_self, completions, hwc_cq->queue_depth);

mana_gd_poll_cq() returns int.  It returns -1 on error.

   292          WARN_ON_ONCE(comp_read <= 0 || comp_read > hwc_cq->queue_depth);

comp_read can't be less than zero because it's unsigned but the warning
for "comp_read > hwc_cq->queue_depth" will trigger.

   293  
   294          for (i = 0; i < comp_read; ++i) {
                            ^^^^^^^^^^^^^
If "comp_read" was declared as an int then this loop would be a harmless
no-op but because it's UINT_MAX on error then this will crash the system.

   295                  comp_data = *(struct hwc_rx_oob *)completions[i].cqe_data;
   296  
   297                  if (completions[i].is_sq)
   298                          hwc_cq->tx_event_handler(hwc_cq->tx_event_ctx,
   299                                                  completions[i].wq_num,
   300                                                  &comp_data);
   301                  else
   302                          hwc_cq->rx_event_handler(hwc_cq->rx_event_ctx,
   303                                                  completions[i].wq_num,
   304                                                  &comp_data);
   305          }
   306  
   307          mana_gd_arm_cq(q_self);
   308  }

regards,
dan carpenter
