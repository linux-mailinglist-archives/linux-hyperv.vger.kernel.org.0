Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 344CB2C9766
	for <lists+linux-hyperv@lfdr.de>; Tue,  1 Dec 2020 07:07:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725859AbgLAGHR (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 1 Dec 2020 01:07:17 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:40010 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725918AbgLAGHR (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 1 Dec 2020 01:07:17 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0B164vi9134342;
        Tue, 1 Dec 2020 06:06:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=v9FjbK+YMkSwYmlVXFkWeigO4WGzHjdoHRKpOyYQsKk=;
 b=qEjP9CY0/bL5hjR1Cv2SqKtovj3kwMXDPVLze7VouXGOOhQQHB7Gx5yqj9iydiNe+4MD
 vpTfmHxuRWyWkbzEn4UhoZSJJiWO6nVD64WHbUTApJrAD4gAH5woSqsJL+c07GyHIhNF
 wvM26cCBzQ4mAp2ZY232tYyzXZsbZKThfRW5TlfLbMDCatELVl0CPVaXBzUS0xGcLwZn
 E9ljNta2giizBwCdfdWta0q1pVzVSWD3yjwmJd2dW7h8t06KgcqIZwW+5CrtI5x2r4pS
 3zMD5ljRmCCE+nycYqJ0VwDCmNCxkYnp7iqMddNyH7f6sXVU+MDLS3cKXESacEBpxdAe Ew== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2130.oracle.com with ESMTP id 353c2arvyp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 01 Dec 2020 06:06:30 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0B165IpG039188;
        Tue, 1 Dec 2020 06:06:29 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3030.oracle.com with ESMTP id 3540fwcqjp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 01 Dec 2020 06:06:29 +0000
Received: from abhmp0002.oracle.com (abhmp0002.oracle.com [141.146.116.8])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 0B166Sur024057;
        Tue, 1 Dec 2020 06:06:28 GMT
Received: from ca-mkp.ca.oracle.com (/10.156.108.201)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 30 Nov 2020 22:06:28 -0800
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
To:     "Andrea Parri (Microsoft)" <parri.andrea@gmail.com>,
        linux-kernel@vger.kernel.org
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Juan Vazquez <juvazq@microsoft.com>,
        Saruhan Karademir <skarade@microsoft.com>,
        Michael Kelley <mikelley@microsoft.com>,
        "K . Y . Srinivasan" <kys@microsoft.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        linux-hyperv@vger.kernel.org, linux-scsi@vger.kernel.org,
        Wei Liu <wei.liu@kernel.org>
Subject: Re: [PATCH] scsi: storvsc: Validate length of incoming packet in storvsc_on_channel_callback()
Date:   Tue,  1 Dec 2020 01:06:24 -0500
Message-Id: <160680263438.25762.16584811025803290259.b4-ty@oracle.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201118145348.109879-1-parri.andrea@gmail.com>
References: <20201118145348.109879-1-parri.andrea@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9821 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=0
 phishscore=0 mlxlogscore=912 adultscore=0 mlxscore=0 bulkscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2012010041
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9821 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 lowpriorityscore=0
 clxscore=1015 bulkscore=0 mlxlogscore=924 phishscore=0 malwarescore=0
 spamscore=0 adultscore=0 mlxscore=0 priorityscore=1501 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2012010041
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Wed, 18 Nov 2020 15:53:48 +0100, Andrea Parri (Microsoft) wrote:

> Check that the packet is of the expected size at least, don't copy
> data past the packet.

Applied to 5.10/scsi-fixes, thanks!

[1/1] scsi: storvsc: Validate length of incoming packet in storvsc_on_channel_callback()
      https://git.kernel.org/mkp/scsi/c/3b8c72d076c4

-- 
Martin K. Petersen	Oracle Linux Engineering
