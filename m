Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 299B54AF55
	for <lists+linux-hyperv@lfdr.de>; Wed, 19 Jun 2019 03:09:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726037AbfFSBJK (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 18 Jun 2019 21:09:10 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:36508 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725988AbfFSBJK (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 18 Jun 2019 21:09:10 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5J14MIZ192415;
        Wed, 19 Jun 2019 01:09:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2018-07-02;
 bh=O0Ag6RZRGGfE7EiTJNqvl7FmPVNtYsR6M0cJqHhvRaQ=;
 b=ALiwAPeHZpWcQeuIU/Mw8YWcHJAqhKvNc03R+vD3Cs0hShAYykcS9Jm9olLHk3qoOgXg
 KJVoGBCzJwcX9ukQqnBrKlCPF6BSBYJ6Kb8Mj2UI12qb8ywbabgV40WzNS+ZyZA2Mqo7
 53QywJU5BHQF6yfqlgNHrr6Aact1yLyfETrV4x8K5wagWXjJ3+27cxCY3ynYPPt6LPIo
 L/lu87YGuVgOSkZlqdlrlih9R5+cnsSmqkYs0FOy0MSe08fpOm5eW51gjRt0JzgmaGYG
 5B9YOpBiuhSGVKRXSucurFnqeZurTLBxDhWGFVAe6Ozw8Udv6cxw9Y7Y9liQMBljjcOX IA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 2t78098fyp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 19 Jun 2019 01:09:03 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5J17dQ8051946;
        Wed, 19 Jun 2019 01:09:03 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3030.oracle.com with ESMTP id 2t77yn1yxb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 19 Jun 2019 01:09:03 +0000
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x5J192bR005720;
        Wed, 19 Jun 2019 01:09:02 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 18 Jun 2019 18:09:01 -0700
To:     Branden Bonaby <brandonbonaby94@gmail.com>
Cc:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        sashal@kernel.org, jejb@linux.ibm.com, martin.petersen@oracle.com,
        linux-hyperv@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] scsi: storvsc: Add ability to change scsi queue depth
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <20190614234822.5193-1-brandonbonaby94@gmail.com>
Date:   Tue, 18 Jun 2019 21:08:59 -0400
In-Reply-To: <20190614234822.5193-1-brandonbonaby94@gmail.com> (Branden
        Bonaby's message of "Fri, 14 Jun 2019 19:48:22 -0400")
Message-ID: <yq1fto6xtxw.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1.92 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9292 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=798
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1906190007
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9292 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=862 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1906190007
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org


Branden,

> Adding functionality to allow the SCSI queue depth to be changed, by
> utilizing the "scsi_change_queue_depth" function.

Applied to 5.3/scsi-queue. Please run checkpatch before submission. I
fixed it up this time.

Thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
