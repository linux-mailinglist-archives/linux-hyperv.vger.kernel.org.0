Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9E01BBC072
	for <lists+linux-hyperv@lfdr.de>; Tue, 24 Sep 2019 04:53:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405950AbfIXCxS (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 23 Sep 2019 22:53:18 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:57386 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728992AbfIXCxS (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 23 Sep 2019 22:53:18 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x8O2ix0B079263;
        Tue, 24 Sep 2019 02:53:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2019-08-05;
 bh=N1cUtOquaBkOk4FnvyuMEMN2i0kLzjsGj2zGsLObV9A=;
 b=QRIWeM6kHZU50aaFnPMwKfOKIyaAmt7NVAuCiYxd01FSm95gpIPEH+0IjyHkLSGzacaX
 GWtcQ55EZfDuRfjTj1QWUa0PoVjvg6Ttlgftt0Jdl6HlQkNFSZvuNzZ05P+oRZ/MWwg6
 Iyq1nbTcy0UmjRgMc4th+UCd2/PYFhkh5zz5T1Laq5JdxHrH0AucMXbIwKwKjSTtLO1x
 GWSBq47+quhBkPJ/xPNXKdAal6FbUGc+RVLgCiG3O8XaUOUba9gL+9dC2rM7ioYlbNIL
 A3eeJeFNna/guyH7/0f3eAFukw/T5R2HsnoxxdQvmVhzqDuWhyuKMChshlNvUDTQbUJK 6g== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 2v5btpty4f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 24 Sep 2019 02:53:12 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x8O2iM4M159030;
        Tue, 24 Sep 2019 02:53:12 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3020.oracle.com with ESMTP id 2v6yvqpc9y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 24 Sep 2019 02:53:11 +0000
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x8O2rASY010053;
        Tue, 24 Sep 2019 02:53:10 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 23 Sep 2019 19:53:10 -0700
To:     longli@linuxonhyperv.com
Cc:     "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Sasha Levin <sashal@kernel.org>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-hyperv@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, Long Li <longli@microsoft.com>
Subject: Re: [Patch v4] storvsc: setup 1:1 mapping between hardware queue and CPU queue
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <1567790660-48142-1-git-send-email-longli@linuxonhyperv.com>
Date:   Mon, 23 Sep 2019 22:53:07 -0400
In-Reply-To: <1567790660-48142-1-git-send-email-longli@linuxonhyperv.com>
        (longli@linuxonhyperv.com's message of "Fri, 6 Sep 2019 10:24:20
        -0700")
Message-ID: <yq1k19y4d7w.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1.92 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9389 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=981
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1909240027
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9389 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1909240027
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org


Long,

> storvsc doesn't use a dedicated hardware queue for a given CPU
> queue. When issuing I/O, it selects returning CPU (hardware queue)
> dynamically based on vmbus channel usage across all channels.

Applied to 5.4/scsi-fixes. Thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
