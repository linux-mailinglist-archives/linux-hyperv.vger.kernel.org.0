Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C731367DCE
	for <lists+linux-hyperv@lfdr.de>; Thu, 22 Apr 2021 11:36:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235716AbhDVJgn (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 22 Apr 2021 05:36:43 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:34124 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235713AbhDVJgl (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 22 Apr 2021 05:36:41 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 13M9Z5MO061269;
        Thu, 22 Apr 2021 09:36:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=pHTKb+48mofghe6I/5QBqPaadVSpPCtsIDoVB30QHoI=;
 b=aYm6tbJ+7EXBy4qoR6+yJo6zG3o3XmmrVLl0FuuS5aoSZ/vabYXBbiHAifeRCYY7nriX
 TpnwB/gZhq4m9V+/d+fzIrBw9yCn0BIO6FrwSuT//Pp3ic3vqKMS4BXbtRTIKuXzhYk2
 gwAIvPnzINAWwg1xWSxOSeD1eMjrsRmMeolyXqRmsyjyl+4bZ+JpgCg5olHod97nKGGr
 6OMcLnEcAMJjHpRzSCF3wSRSDRQzHpOEV7jOqPkXdGTuabEGIU/ZVtlDI4/2Don3smnb
 T/FMAc1HtnmD5zsVgMNjlua9r8cR7tY6bTh4ems6Yc3r7PXBI8bIB5ZvbKD2hbbZtg0k og== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 37yqmnmuav-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 22 Apr 2021 09:36:04 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 13M9Uu1E027889;
        Thu, 22 Apr 2021 09:36:04 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by userp3030.oracle.com with ESMTP id 3809m1y5t6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 22 Apr 2021 09:36:04 +0000
Received: from userp3030.oracle.com (userp3030.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 13M9Wb9K036371;
        Thu, 22 Apr 2021 09:36:03 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3030.oracle.com with ESMTP id 3809m1y5sh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 22 Apr 2021 09:36:03 +0000
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 13M9a2td020153;
        Thu, 22 Apr 2021 09:36:02 GMT
Received: from kadam (/102.36.221.92)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 22 Apr 2021 02:36:01 -0700
Date:   Thu, 22 Apr 2021 12:35:34 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Dexuan Cui <decui@microsoft.com>
Cc:     "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>
Subject: Re: [bug report] net: mana: Add a driver for Microsoft Azure Network
 Adapter (MANA)
Message-ID: <20210422093534.GM1959@kadam>
References: <YH/5OQSEbCBvH9ju@mwanda>
 <MW2PR2101MB089292B02804E3521B31219EBF469@MW2PR2101MB0892.namprd21.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MW2PR2101MB089292B02804E3521B31219EBF469@MW2PR2101MB0892.namprd21.prod.outlook.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-ORIG-GUID: hnmv0Jnu3vIWXUjrsEQ84XpDJ3A09krt
X-Proofpoint-GUID: hnmv0Jnu3vIWXUjrsEQ84XpDJ3A09krt
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9961 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 adultscore=0
 impostorscore=0 spamscore=0 malwarescore=0 clxscore=1015
 lowpriorityscore=0 priorityscore=1501 suspectscore=0 mlxlogscore=999
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104220080
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Thu, Apr 22, 2021 at 08:06:36AM +0000, Dexuan Cui wrote:
> 
> Hi Dan,
> Thanks for reporting the bug! I'll learn how to use a static tool to avoid
> this kind of bugs in future. :-)
> 
> I'll post the below patch with your Reported-by:

Thanks!

regards,
dan carpenter

