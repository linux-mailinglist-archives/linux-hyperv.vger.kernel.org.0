Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8897E2C976A
	for <lists+linux-hyperv@lfdr.de>; Tue,  1 Dec 2020 07:07:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726880AbgLAGHY (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 1 Dec 2020 01:07:24 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:50502 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725918AbgLAGHY (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 1 Dec 2020 01:07:24 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0B164sfl032738;
        Tue, 1 Dec 2020 06:06:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=X/15MCiGUod+DO7nKonw8hTgKuz/vpJgfYtZY9yA0+I=;
 b=iobFJmp0uOE1zDAfEMqZ9Br4lWjjy6FyGyF0P40IFdxbTvaTdOrlYhOMUDv8jlvfefjm
 vW1d+KugoNU/zLXf9sM+UzKOHLw3yP0yKMETcVY1JANofbtR0V8U7zvWO2c6TIEAUNt9
 +LMQ1X97lX8BpTgICzL9GdzQ4lL9rGAUcx2pWRxK6rSU3V1J4bCv0dCmeVtXTYUkLx+s
 V37QU7Xtw3WG6XA1grlX/m6gJG8Vu1uxMTA8prnN2skvNUrMPUNCjBnpOKL7eAPoahq2
 AJtW9KXexTSuHPmNAfa8LS/9wfG6uw3u1t6viTcMsKtyhtPB/qyXYHnvxtWOLjDzQbBR bA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 353egkgr3a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 01 Dec 2020 06:06:30 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0B165HWK039155;
        Tue, 1 Dec 2020 06:06:29 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3030.oracle.com with ESMTP id 3540fwcqj8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 01 Dec 2020 06:06:29 +0000
Received: from abhmp0020.oracle.com (abhmp0020.oracle.com [141.146.116.26])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 0B166RpH023997;
        Tue, 1 Dec 2020 06:06:27 GMT
Received: from ca-mkp.ca.oracle.com (/10.156.108.201)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 01 Dec 2020 06:06:27 +0000
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
To:     cavery@redhat.com, longli@microsoft.com, jejb@linux.ibm.com,
        wei.liu@kernel.org, kys@microsoft.com, sthemmin@microsoft.com,
        Jing Xiangfeng <jingxiangfeng@huawei.com>,
        haiyangz@microsoft.com
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-hyperv@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] scsi: storvsc: Fix error return in storvsc_probe()
Date:   Tue,  1 Dec 2020 01:06:23 -0500
Message-Id: <160680263437.25762.10714244470298339724.b4-ty@oracle.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201127030206.104616-1-jingxiangfeng@huawei.com>
References: <20201127030206.104616-1-jingxiangfeng@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9821 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=0
 phishscore=0 mlxlogscore=999 adultscore=0 mlxscore=0 bulkscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2012010041
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9821 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 suspectscore=0
 phishscore=0 mlxlogscore=999 lowpriorityscore=0 malwarescore=0
 priorityscore=1501 spamscore=0 impostorscore=0 clxscore=1011 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2012010041
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Fri, 27 Nov 2020 11:02:06 +0800, Jing Xiangfeng wrote:

> Fix to return a error code "-ENOMEM" from the error handling case
> instead of 0.

Applied to 5.10/scsi-fixes, thanks!

[1/1] scsi: storvsc: Fix error return in storvsc_probe()
      https://git.kernel.org/mkp/scsi/c/6112ff4e8f39

-- 
Martin K. Petersen	Oracle Linux Engineering
