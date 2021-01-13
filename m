Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 829D72F4424
	for <lists+linux-hyperv@lfdr.de>; Wed, 13 Jan 2021 06:51:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725801AbhAMFuN (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 13 Jan 2021 00:50:13 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:37256 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725747AbhAMFuN (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 13 Jan 2021 00:50:13 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10D5i7jT096277;
        Wed, 13 Jan 2021 05:49:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=mime-version :
 message-id : date : from : to : cc : subject : references : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=Gf1QDWGX+0TpoVLmuwqjv9HvqUj0wHUQztxmJ0/kLSI=;
 b=nlW0jzhWd4GUjwvAaPgwpCwVCEQEic6rMyBLXdHKQWJU6JrNXodDZlmrW36QTyfv1ujQ
 OU2RrZNRjUG9nrSmEJNy8bjddQ1j9SPVLNyuySJo3BKmvcv0H+TlMYEagQx4aCSHmQFp
 PcFky7hJLoM+xqkSd8gcNJgAz412PFZnt4pba5vTrfiyzecZvmfQvNjXJcmJhv+H9oj+
 68Lv2wmnKaUWFIF/eC5Pkna1MYnkAdgjCmTuvIDW9KlK5Xbev0lsm8xbbIO+T0guOPzz
 dSy7oUMBygU31YiPMpd3YTEb2iRtkw3a31OP9dEHze1/JMDWtt/2IwPRIzhUnZCGcvzr hg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 360kcysp4p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 13 Jan 2021 05:49:25 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10D5dhJS159263;
        Wed, 13 Jan 2021 05:49:25 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3020.oracle.com with ESMTP id 360ke7rmb1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 13 Jan 2021 05:49:25 +0000
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 10D5nNHL024123;
        Wed, 13 Jan 2021 05:49:23 GMT
Received: from ca-mkp.ca.oracle.com (/10.156.108.201) by default (Oracle
 Beehive Gateway v4.0) with ESMTP ; Tue, 12 Jan 2021 21:48:39 -0800
MIME-Version: 1.0
Message-ID: <161050726820.14224.523425689626280700.b4-ty@oracle.com>
Date:   Tue, 12 Jan 2021 21:48:26 -0800 (PST)
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
To:     "Andrea Parri (Microsoft)" <parri.andrea@gmail.com>,
        linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        Juan Vazquez <juvazq@microsoft.com>,
        Michael Kelley <mikelley@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        "K . Y . Srinivasan" <kys@microsoft.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        linux-scsi@vger.kernel.org,
        Saruhan Karademir <skarade@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>
Subject: Re: [PATCH 0/3] scsi: storvsc: Validate length of incoming packet in
 storvsc_on_channel_callback() -- Take 2
References: <20201217203321.4539-1-parri.andrea@gmail.com>
In-Reply-To: <20201217203321.4539-1-parri.andrea@gmail.com>
X-Mailer: git-send-email 2.29.2
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9862 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0 spamscore=0
 mlxlogscore=998 malwarescore=0 bulkscore=0 mlxscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101130034
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9862 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0
 impostorscore=0 bulkscore=0 adultscore=0 suspectscore=0 malwarescore=0
 lowpriorityscore=0 clxscore=1015 mlxlogscore=999 mlxscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2101130034
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Thu, 17 Dec 2020 21:33:18 +0100, Andrea Parri (Microsoft) wrote:

> This series is to address the problems mentioned in:
> 
>   4da3a54f5a0258 ("Revert "scsi: storvsc: Validate length of incoming packet in storvsc_on_channel_callback()"")
> 
> (cf., in particular, patch 2/3) and to re-introduce the validation in
> question (patch 3/3); patch 1/3 emerged from internal review of these
> two patches and is a related fix.
> 
> [...]

Applied to 5.12/scsi-queue, thanks!

[1/3] scsi: storvsc: Fix max_outstanding_req_per_channel for Win8 and newer
      https://git.kernel.org/mkp/scsi/c/ab548fd21e1c
[2/3] scsi: storvsc: Resolve data race in storvsc_probe()
      https://git.kernel.org/mkp/scsi/c/244808e03029
[3/3] scsi: storvsc: Validate length of incoming packet in storvsc_on_channel_callback()
      https://git.kernel.org/mkp/scsi/c/91b1b640b834

-- 
Martin K. Petersen	Oracle Linux Engineering
