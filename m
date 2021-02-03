Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A6C730D71C
	for <lists+linux-hyperv@lfdr.de>; Wed,  3 Feb 2021 11:12:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233758AbhBCKMN (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 3 Feb 2021 05:12:13 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:57696 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233379AbhBCKLe (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 3 Feb 2021 05:11:34 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 1139nhwk135564;
        Wed, 3 Feb 2021 10:10:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2020-01-29;
 bh=eMGaSgAJr0HSoactqLZ9g3DFG9BP7c483LrgYzzyCc4=;
 b=DkBfod+2yQzJXJ3qr9oMzoyYjFKIYOElE8MfuG+wvsYQb0at8GWJCQSBo87Zfx7yPW6b
 SyKKdkPsgVSYpdTGAdWe53ZT0aeR0QyZVWEXCY1aEqOomnk010U9iZ6ep2/rxK67P64z
 zM76GFJSGWhbmWX9aa29SNnq5Dav+Df3FrgkoxYiwRUD+XLKOF3JcgVXXaLEdNXN9I6v
 6D8+GpVf9Dmm9HQAdNmiOnK9lScGV7oBNCK8fZgmnd3JZb6TnejACX9/tst8DPI6HJXf
 mN+V7Jkk/ql2eJp7NzqRHpd4d39VmxnGiMJppWeqLKPM26+2L7cTsX872ZWpDsVzmwVy SA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 36fs4587kq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 03 Feb 2021 10:10:50 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 1139nWAu139887;
        Wed, 3 Feb 2021 10:10:48 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3030.oracle.com with ESMTP id 36dh1qj771-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 03 Feb 2021 10:10:48 +0000
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 113AAka7008543;
        Wed, 3 Feb 2021 10:10:47 GMT
Received: from mwanda (/10.175.206.62)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 03 Feb 2021 02:10:46 -0800
Date:   Wed, 3 Feb 2021 13:10:41 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     parri.andrea@gmail.com
Cc:     linux-hyperv@vger.kernel.org
Subject: [bug report] hv_netvsc: Copy packets sent by Hyper-V out of the
 receive buffer
Message-ID: <YBp2oVIdMe+G/liJ@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Proofpoint-IMR: 1
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9883 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0 phishscore=0
 suspectscore=0 mlxlogscore=880 bulkscore=0 mlxscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102030061
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9883 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 adultscore=0
 malwarescore=0 priorityscore=1501 impostorscore=0 suspectscore=0
 phishscore=0 clxscore=1011 lowpriorityscore=0 spamscore=0 mlxlogscore=786
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102030061
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Hello Andrea Parri (Microsoft),

This is a semi-automatic email about new static checker warnings.

The patch 0ba35fe91ce3: "hv_netvsc: Copy packets sent by Hyper-V out
of the receive buffer" from Jan 26, 2021, leads to the following
Smatch complaint:

    drivers/net/hyperv/rndis_filter.c:468 rsc_add_data()
    error: we previously assumed 'csum_info' could be null (see line 460)

drivers/net/hyperv/rndis_filter.c
   459			}
   460			if (csum_info != NULL) {
                            ^^^^^^^^^^^^^^^^^
"csum_info" can be NULL.

   461				memcpy(&nvchan->rsc.csum_info, csum_info, sizeof(*csum_info));
   462				nvchan->rsc.ppi_flags |= NVSC_RSC_CSUM_INFO;
   463			} else {
   464				nvchan->rsc.ppi_flags &= ~NVSC_RSC_CSUM_INFO;
   465			}
   466			nvchan->rsc.pktlen = len;
   467			if (hash_info != NULL) {
   468				nvchan->rsc.csum_info = *csum_info;
                                                        ^^^^^^^^^^^
Unchecked dereference.  Plus this has "csum_info" on both sides of the
assignment so maybe it is a copy and paste error?  This is equivalent to
the "memcpy(&nvchan->rsc.csum_info, csum_info, sizeof(*csum_info));"
in the ealier if statement but stated as an assignment instead of a
memcpy().

   469				nvchan->rsc.ppi_flags |= NVSC_RSC_HASH_INFO;
   470			} else {

regards,
dan carpenter
