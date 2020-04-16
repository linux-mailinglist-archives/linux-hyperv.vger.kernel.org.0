Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BFB21ABD83
	for <lists+linux-hyperv@lfdr.de>; Thu, 16 Apr 2020 12:05:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2504601AbgDPKFV (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 16 Apr 2020 06:05:21 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:44560 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2504310AbgDPKFS (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 16 Apr 2020 06:05:18 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03GA3t0N058854;
        Thu, 16 Apr 2020 10:05:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=za4AVK/k+Uk/xp/mb5oy2jiuIMPpSLqLYxS4y/rP7RI=;
 b=zNSu5gGBQZG2ZHS9VftxnWNm1cNTfb8vl+2zgIZiW36CEOxTNZfSAM2xXJVjFiKMVvhZ
 EimN3olqdChKtACSzW8YW1HP/6ljcbGNjqOt0mrjz7oAEo3IhPWRPI0zy08aiF9XqGjI
 CbZj9iDBrR1yPjCvD+6mo7JU6HIqgFazliO/yrT8AWdG8mfe3cGRn9L6HvZwGUdY86cF
 AfB/CEeNsBYZyWRLDFBITGHGkSL4pM35v8mOEHDL2Azwv0C1g6nlClWBkI8fMtXyIIh2
 qea0T9PxoQNTWhoViITGYnUAY6pOAiydqttDixmFx2i/zmk0A2S0hE/WZreTWPD3rNbh hg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 30emejg829-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 16 Apr 2020 10:05:08 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03GA26sa063645;
        Thu, 16 Apr 2020 10:03:07 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3020.oracle.com with ESMTP id 30dn9exfch-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 16 Apr 2020 10:03:07 +0000
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 03GA36Xm002520;
        Thu, 16 Apr 2020 10:03:06 GMT
Received: from kadam (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 16 Apr 2020 03:03:05 -0700
Date:   Thu, 16 Apr 2020 13:02:54 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Wei Liu <wei.liu@kernel.org>
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Colin Ian King <colin.king@canonical.com>,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        "K . Y . Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        linux-hyperv@vger.kernel.org
Subject: Re: [PATCH][next] drivers: hv: remove redundant assignment to
 pointer primary_channel
Message-ID: <20200416100253.GN1163@kadam>
References: <20200414152343.243166-1-colin.king@canonical.com>
 <87d08axb7k.fsf@vitty.brq.redhat.com>
 <606c442c-1923-77d4-c350-e06878172c44@canonical.com>
 <87wo6hvxkz.fsf@vitty.brq.redhat.com>
 <20200415143752.cm3xbesiuksfdbzm@debian>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200415143752.cm3xbesiuksfdbzm@debian>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9592 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0 adultscore=0
 spamscore=0 phishscore=0 bulkscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004160069
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9592 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 impostorscore=0
 mlxscore=0 suspectscore=0 lowpriorityscore=0 spamscore=0 mlxlogscore=999
 bulkscore=0 adultscore=0 phishscore=0 clxscore=1011 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004160069
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

We have this discussion over and over.  I always say it helps to have
the commit mentioned in the commit message but it's not a Fixes tag.
So I think that the commit message should say something like
"commit 1234234 ("blah blah") removed some code so this variable isn't
used any more".  I think it helps the review process.  But then if we
mention the commit everyone says to use the Fixes tag.

It turns out if you leave out the commit entirely then people still
complain but a lot less frequently.  It shouldn't work that way but
reviewers are illogical.

regards,
dan carpenter

