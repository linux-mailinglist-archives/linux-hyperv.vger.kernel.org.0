Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6810B6B4E2
	for <lists+linux-hyperv@lfdr.de>; Wed, 17 Jul 2019 05:08:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728125AbfGQDI3 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 16 Jul 2019 23:08:29 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:57436 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726069AbfGQDI2 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 16 Jul 2019 23:08:28 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6H35cca191468;
        Wed, 17 Jul 2019 03:08:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2018-07-02;
 bh=UEaaAVvgCGyb+7Yj61X9MJGTm0YgTvSRv1ONnMOutJQ=;
 b=GOiTdgfTFSbb/EFuPcJN7jTYkY32Qmns5pYKAj8sb8IUcHKX3AiiAvu0KZr2DhGuUTjl
 Q+ViMT+0FbMmKkcPnICdmmxs+N+7nfidYVrJDJsF3cXRn0PLLpbAfF2s3M7HLZv0gYfj
 WNqq+LZR5C8T+WQ0Vdks5WvoyMpZaAnPccg6+SN5MIYBLpU6kfSOxxbmnsSvzWTTdLZM
 brw8TGVSUYnNBT4KD2ukTj6IdHno3pnlq/aIADGZlnIFmhVSgz3vb9x1y5cGcIIffbgh
 jvOO1we7rSUyeE9/yl0uH6nLZFtLVSeZ7ecKJmDL0/wp2mT4NG3B8YXVUcdziP4fQpvR 0g== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 2tq78pquay-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 17 Jul 2019 03:08:00 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6H32jv8038951;
        Wed, 17 Jul 2019 03:08:00 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3030.oracle.com with ESMTP id 2tq4du8s0c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 17 Jul 2019 03:08:00 +0000
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x6H37wC2022960;
        Wed, 17 Jul 2019 03:07:58 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 17 Jul 2019 03:07:58 +0000
To:     Christoph Hellwig <hch@lst.de>
Cc:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Max Gurtovoy <maxg@mellanox.com>,
        Bart Van Assche <bvanassche@acm.org>,
        linux-rdma@vger.kernel.org, linux-scsi@vger.kernel.org,
        megaraidlinux.pdl@broadcom.com, MPT-FusionLinux.pdl@broadcom.com,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: properly communicate queue limits to the DMA layer v2
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <20190617122000.22181-1-hch@lst.de>
        <20190715165823.GA10029@lst.de> <yq1tvbn2ofc.fsf@oracle.com>
        <20190715174617.GA11094@lst.de>
Date:   Tue, 16 Jul 2019 23:07:55 -0400
In-Reply-To: <20190715174617.GA11094@lst.de> (Christoph Hellwig's message of
        "Mon, 15 Jul 2019 19:46:17 +0200")
Message-ID: <yq1y30xxss4.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1.92 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9320 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=907
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1907170036
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9320 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=953 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1907170036
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org


Christoph,

> I think all the patches on the block side went into 5.2, but it's been
> a while, so I might misremember..

I checked my notes and the reason I held them back was that I was
waiting for a response from Broadcom wrt. the megaraid segment size
limitation.  However, given that mpt3sas was acked, I assume it's the
same thing.

I'm not so keen on how big the last batch of patches for the merge
window is getting. But I queued your fixes up for 5.3.

-- 
Martin K. Petersen	Oracle Linux Engineering
