Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9382201FF7
	for <lists+linux-hyperv@lfdr.de>; Sat, 20 Jun 2020 04:58:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732197AbgFTC6w (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 19 Jun 2020 22:58:52 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:46258 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732074AbgFTC6w (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 19 Jun 2020 22:58:52 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 05K2w49M163863;
        Sat, 20 Jun 2020 02:58:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : mime-version :
 content-type; s=corp-2020-01-29;
 bh=oJxOHBOfLtTRTFG6TrbaXmG/4Aimtja3g9KTsPz4fvU=;
 b=h1sUhdeUH11Z1Tp79XWoN/Ow7sa676uCgWU9PvD9SA7dhpVZD/QnOPj73l2vfruC5gg9
 OtpqcxpuUvZZv5adZTExEfi1rFNDg+vJkcvIZ3d3UNfe8MyhRlcn2+fTOuV2++d0JCNt
 nUjL3KrWTuFk8XipG1QlNURrwjJuLULk2aIrcztq/3NY7F/kaogveF4POCXGB7DHa1/w
 OUa817RYM9utjAOQ0qLYSCLOfXMGZudzT9/KhNbYmB5qVAhVChOW+YnRxh7En8sOsAb1
 KtGuAdtjdo3C2L91OeaYyzqbUaKWu8AK6JLIolbrJ3vuZKQUyTC3B+FsTVu6kxaTNIT0 DQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 31qecm7xgq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sat, 20 Jun 2020 02:58:46 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 05K2wkPI111980;
        Sat, 20 Jun 2020 02:58:46 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3030.oracle.com with ESMTP id 31s7jqdkyx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 20 Jun 2020 02:58:46 +0000
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 05K2wgKc000471;
        Sat, 20 Jun 2020 02:58:43 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 19 Jun 2020 19:58:42 -0700
To:     Andrea Parri <parri.andrea@gmail.com>
Cc:     Wei Liu <wei.liu@kernel.org>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        "K . Y . Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Michael Kelley <mikelley@microsoft.com>,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-scsi@vger.kernel.org
Subject: Re: [PATCH 7/8] scsi: storvsc: Introduce the per-storvsc_device
 spinlock
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1tuz6h29e.fsf@ca-mkp.ca.oracle.com>
References: <20200617164642.37393-1-parri.andrea@gmail.com>
        <20200617164642.37393-8-parri.andrea@gmail.com>
        <20200619160136.2r34bdu26hxixv7l@liuwe-devbox-debian-v2>
        <20200619161813.GA1596681@andrea>
Date:   Fri, 19 Jun 2020 22:58:40 -0400
In-Reply-To: <20200619161813.GA1596681@andrea> (Andrea Parri's message of
        "Fri, 19 Jun 2020 18:18:13 +0200")
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9657 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 adultscore=0 mlxscore=0
 mlxlogscore=896 phishscore=0 bulkscore=0 malwarescore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006200019
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9657 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 cotscore=-2147483648 malwarescore=0
 clxscore=1011 adultscore=0 suspectscore=1 spamscore=0 lowpriorityscore=0
 mlxlogscore=919 priorityscore=1501 bulkscore=0 phishscore=0 mlxscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2006200019
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org


Andrea,

>> This patch should go via the hyperv tree because a later patch is
>> dependent on it. It requires and ack from SCSI maintainers though.

Looks OK to me.

Acked-by: Martin K. Petersen <martin.petersen@oracle.com>

-- 
Martin K. Petersen	Oracle Linux Engineering
