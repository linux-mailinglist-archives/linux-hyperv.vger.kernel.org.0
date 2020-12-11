Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F5702D7895
	for <lists+linux-hyperv@lfdr.de>; Fri, 11 Dec 2020 16:06:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406445AbgLKPA0 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 11 Dec 2020 10:00:26 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:37892 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2436901AbgLKPAY (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 11 Dec 2020 10:00:24 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0BBEuMWA181636;
        Fri, 11 Dec 2020 14:59:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : mime-version :
 content-type; s=corp-2020-01-29;
 bh=4rzbePKaXv5WgRAgbzQku9hQ+epeAIFDKl+N4EYfs6s=;
 b=yffXGhp/UZT1Ftpwe/s8TJjVHf1lcAt431cAc/ts1wRWPzpnX9HIqlj9QNaSbmtD0saa
 fCQA10O+wRAlf4oBtPF0iqWbLItb7HB66v6YsOicwemrktTtOfv/2F6zZ7k8CuHJBJ/K
 u1IaYz3Kw8iFGPn89SymngTy8kVp88rI3jjJ1++0ghIrdy96jXeob0det81eBtZB8UzP
 uujGEFzjTd603dM3B3eemcQ4wSEcXDjktrtQDHmrj3+hUEDp5d46/fmiKVzJ4uynOYG7
 bwFOrxxM6uHjvkzQCJLSxDgdBe8cxYQXAg2ch3scHQZIDsvc97NISAyvc6ogpflwsRV7 bw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2130.oracle.com with ESMTP id 357yqcb3ks-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 11 Dec 2020 14:59:38 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0BBEsv0D151835;
        Fri, 11 Dec 2020 14:59:38 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3030.oracle.com with ESMTP id 358kstgdag-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 11 Dec 2020 14:59:38 +0000
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 0BBExbhh028238;
        Fri, 11 Dec 2020 14:59:37 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 11 Dec 2020 06:59:37 -0800
To:     Wei Liu <wei.liu@kernel.org>
Cc:     "Andrea Parri (Microsoft)" <parri.andrea@gmail.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org,
        "K . Y . Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Dexuan Cui <decui@microsoft.com>,
        Michael Kelley <mikelley@microsoft.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        linux-scsi@vger.kernel.org
Subject: Re: [PATCH] Revert "scsi: storvsc: Validate length of incoming
 packet in storvsc_on_channel_callback()"
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1pn3go0ft.fsf@ca-mkp.ca.oracle.com>
References: <20201211131404.21359-1-parri.andrea@gmail.com>
        <20201211140137.taqjndaqjjo25srj@liuwe-devbox-debian-v2>
Date:   Fri, 11 Dec 2020 09:59:34 -0500
In-Reply-To: <20201211140137.taqjndaqjjo25srj@liuwe-devbox-debian-v2> (Wei
        Liu's message of "Fri, 11 Dec 2020 14:01:37 +0000")
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9831 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 suspectscore=1
 bulkscore=0 malwarescore=0 phishscore=0 mlxscore=0 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2012110098
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9831 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 mlxlogscore=999
 clxscore=1011 malwarescore=0 bulkscore=0 phishscore=0 adultscore=0
 spamscore=0 priorityscore=1501 mlxscore=0 lowpriorityscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2012110098
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org


Wei,

> Sorry for the last minute patch. We would very like this goes into
> 5.10 if possible; otherwise Linux 5.10 is going to be broken on
> Hyper-V.  :-(

Applied to 5.10/scsi-fixes.

-- 
Martin K. Petersen	Oracle Linux Engineering
