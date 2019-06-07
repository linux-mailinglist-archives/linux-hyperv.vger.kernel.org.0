Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B18B33934B
	for <lists+linux-hyperv@lfdr.de>; Fri,  7 Jun 2019 19:32:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730937AbfFGRbw (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 7 Jun 2019 13:31:52 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:50960 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729355AbfFGRbw (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 7 Jun 2019 13:31:52 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x57HIpx6178003;
        Fri, 7 Jun 2019 17:30:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2018-07-02;
 bh=g9qgPYWy2UeZZX7Q5xvayFUZ5+Jlv5AgZT4Wz1d17eI=;
 b=GquEmfpf1HBT7vX2CzX+dMvzNB0wpOB4iQtcXeOAyF2DoiXBKIsxxFSTqxuQEeD3dFsE
 NW/2qE6nTYp8yIdaZlmQWE+LLZF9hQdENVg3wyoapAls1vxX2q+9hAztXIlTcBohI7iE
 puGOc+EVwd+Wj8du+nhWNsaHMeyQXzpQZb9TZBrehPH95mB9xQPTriWtztvyVvBfZJSY
 ZvDGQ2w0kte1RG2ckQVBBt6EnYhIHB7zOIRVQHpveA/dR7UH9rQ/u//0E/s5itVU17r+
 9iPvrwQcznyJ2mXDhgxzinr5bV6Wic02t6r2sOO0mi4aLy1ulC69fy/YracyVTUd+Ixp yw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 2suj0qyhpc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 07 Jun 2019 17:30:37 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x57HU97U102069;
        Fri, 7 Jun 2019 17:30:36 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3020.oracle.com with ESMTP id 2swngk4vhc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 07 Jun 2019 17:30:36 +0000
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x57HUY6s025234;
        Fri, 7 Jun 2019 17:30:34 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 07 Jun 2019 10:30:34 -0700
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Christoph Hellwig <hch@lst.de>,
        Sebastian Ott <sebott@linux.ibm.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Max Gurtovoy <maxg@mellanox.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Oliver Neukum <oneukum@suse.com>, linux-block@vger.kernel.org,
        linux-rdma@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org,
        megaraidlinux.pdl@broadcom.com, MPT-FusionLinux.pdl@broadcom.com,
        linux-hyperv@vger.kernel.org, linux-usb@vger.kernel.org,
        usb-storage@lists.one-eyed-alien.net, linux-kernel@vger.kernel.org
Subject: Re: properly communicate queue limits to the DMA layer
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <20190605190836.32354-1-hch@lst.de>
        <591cfa1e-fecb-7d00-c855-3b9eb8eb8a2a@kernel.dk>
        <20190605192405.GA18243@lst.de>
        <f07d0abf-b3eb-f530-37b9-e66454740b3f@kernel.dk>
Date:   Fri, 07 Jun 2019 13:30:30 -0400
In-Reply-To: <f07d0abf-b3eb-f530-37b9-e66454740b3f@kernel.dk> (Jens Axboe's
        message of "Thu, 6 Jun 2019 23:52:35 -0600")
Message-ID: <yq1o939i9qh.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1.92 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9281 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=528
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1906070116
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9281 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=574 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1906070116
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org


Jens,

>> The SCSI bits will need a bit more review, and possibly tweaking
>> fo megaraid and mpt3sas.  But they are really independent of the
>> other patches, so maybe skip them for now and leave them for Martin
>> to deal with.
>
> I dropped the SCSI bits.

I'll monitor and merge them.

-- 
Martin K. Petersen	Oracle Linux Engineering
