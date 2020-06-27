Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62DE320BDDC
	for <lists+linux-hyperv@lfdr.de>; Sat, 27 Jun 2020 05:12:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725913AbgF0DMC (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 26 Jun 2020 23:12:02 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:39226 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725828AbgF0DMB (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 26 Jun 2020 23:12:01 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 05R37vv3140502;
        Sat, 27 Jun 2020 03:11:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2020-01-29;
 bh=79n0yP2E0urM7J9cphmsH/pB5gLFdCBUFtsUNABsMDs=;
 b=YBWQHKZnDimN8ZXp7UlFIktcS/ES8k0kyCaj5qcATH11GchXE0n5+FeAAudDMjKDuiNo
 ms9+3G7oX2W0nxXvCPRKMyZWduJKeXuCiBE955I1G+gcHwDvqcKgQbN1TueLcYbeUsjV
 XyqTBeBpavz3RPrlTIvsMZ+ZsUanrnkimsD2pwsVCnIfpwg5wwYlhO59D9W4sYHd0wTU
 utObHlYkSY7IvjfCchSUG+EKWUPDB1/VOlji82ebOvX4ol9niviiP8TAkUT7NQXjplX3
 IJU3k8L5I5xY4ZT+a9nZ5rnXsEL9L4LpJ8eouWFM6uq+1hswFsuKQDvbbgOLUJcrcj1J Mw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 31wg3bkch4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sat, 27 Jun 2020 03:11:39 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 05R37eeh050996;
        Sat, 27 Jun 2020 03:09:39 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3030.oracle.com with ESMTP id 31wu7rmmh8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 27 Jun 2020 03:09:39 +0000
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 05R39UkY010863;
        Sat, 27 Jun 2020 03:09:31 GMT
Received: from ca-mkp.ca.oracle.com (/10.156.108.201)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sat, 27 Jun 2020 03:09:30 +0000
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
To:     Flavio Suligoi <f.suligoi@asem.it>, Wei Liu <wei.liu@kernel.org>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "K . Y . Srinivasan" <kys@microsoft.com>
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hyperv@vger.kernel.org
Subject: Re: [PATCH 1/1] scsi: storvsc: fix spelling mistake
Date:   Fri, 26 Jun 2020 23:09:23 -0400
Message-Id: <159322718420.11145.17016088953064331860.b4-ty@oracle.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200624135600.14274-1-f.suligoi@asem.it>
References: <20200624135600.14274-1-f.suligoi@asem.it>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9664 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=989 bulkscore=0 spamscore=0
 malwarescore=0 adultscore=0 mlxscore=0 suspectscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006270020
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9664 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0 phishscore=0
 malwarescore=0 cotscore=-2147483648 adultscore=0 lowpriorityscore=0
 impostorscore=0 clxscore=1015 mlxscore=0 mlxlogscore=999 spamscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2006270020
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Wed, 24 Jun 2020 15:56:00 +0200, Flavio Suligoi wrote:

> Fix typo: "trigerred" --> "triggered"

Applied to 5.9/scsi-queue, thanks!

[1/1] scsi: storvsc: Fix spelling mistake
      https://git.kernel.org/mkp/scsi/c/fbca7a04dbd8

-- 
Martin K. Petersen	Oracle Linux Engineering
