Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0A325B28A0
	for <lists+linux-hyperv@lfdr.de>; Sat, 14 Sep 2019 00:48:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404099AbfIMWrt (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 13 Sep 2019 18:47:49 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:60888 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404024AbfIMWrt (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 13 Sep 2019 18:47:49 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x8DMdhCe030593;
        Fri, 13 Sep 2019 22:47:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2019-08-05;
 bh=XQBdn8URejM5X7vfjRpH4pKgGwioD1EvG7txGYNwdzQ=;
 b=ktdhGVN4kSmZZ4OkBXcP3iPJPDM5ENuGCFxV8Xc2Emqc20HZVmRrx1nBZd94a83W+6MD
 vY7s83bZ+IhoqIddCk3eF6P7iTrHDDe2aXE44d+NG6Shm8ItpEruOL0REaxrcui2Be0I
 p+iUuTWNMHuzPN7bX1AhFUr2Z+1HSPvWTm7X4X0mG9k100f0/ZBTAchEg2Sy/PpuXxEo
 ef6pCCcjMFfZqJcEBJV1e+RS4TaM+Oxi6rb6udaW9Kn+n2B7xaDoLvNPlEILTz95dQY3
 RBXo3SwK3g5mVOrjDSU5hSgKUZp6VkFNqW10k5K9BaJ22VehjfyF2v08LxOMwLoZ8TLh bg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 2uytd3q9a7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 13 Sep 2019 22:47:42 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x8DMdWxZ128809;
        Fri, 13 Sep 2019 22:47:42 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3030.oracle.com with ESMTP id 2v0cwk5qgm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 13 Sep 2019 22:47:42 +0000
Received: from abhmp0007.oracle.com (abhmp0007.oracle.com [141.146.116.13])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x8DMlfxE008564;
        Fri, 13 Sep 2019 22:47:41 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 13 Sep 2019 15:47:40 -0700
To:     Dexuan Cui <decui@microsoft.com>
Cc:     KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "sashal\@kernel.org" <sashal@kernel.org>,
        "jejb\@linux.ibm.com" <jejb@linux.ibm.com>,
        "martin.petersen\@oracle.com" <martin.petersen@oracle.com>,
        "linux-hyperv\@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-scsi\@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Michael Kelley <mikelley@microsoft.com>
Subject: Re: [PATCH] scsi: storvsc: Add the support of hibernation
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <1568244905-66625-1-git-send-email-decui@microsoft.com>
Date:   Fri, 13 Sep 2019 18:47:38 -0400
In-Reply-To: <1568244905-66625-1-git-send-email-decui@microsoft.com> (Dexuan
        Cui's message of "Wed, 11 Sep 2019 23:35:16 +0000")
Message-ID: <yq1zhj7byph.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1.92 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9379 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=645
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1909130222
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9379 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=711 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1909130222
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org


Dexuan,

> When we're in storvsc_suspend(), we're sure the SCSI layer has
> quiesced the scsi device by scsi_bus_suspend() -> ... ->
> scsi_device_quiesce(), so the low level SCSI adapter driver only needs
> to suspend/resume its own state.

Acked-by: Martin K. Petersen <martin.petersen@oracle.com>

-- 
Martin K. Petersen	Oracle Linux Engineering
