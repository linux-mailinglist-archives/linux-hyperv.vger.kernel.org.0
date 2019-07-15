Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 13E77699F3
	for <lists+linux-hyperv@lfdr.de>; Mon, 15 Jul 2019 19:33:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731596AbfGORdj (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 15 Jul 2019 13:33:39 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:37574 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731574AbfGORdj (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 15 Jul 2019 13:33:39 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6FHXN4s121134;
        Mon, 15 Jul 2019 17:33:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2018-07-02;
 bh=gexxm3URun3t6lGz43qhoYeB1J6VhTPrI1NDhmfisns=;
 b=H7jvnJXUCnBQ32KffKAvXVMToEYJwjQAZixNdxTyXrDMOihdVbRb+DCoVORek7Rj3PC6
 2a2O65v8hb1g6t90c5HrTn4e3nkm3sp597K55lcbE0uoP+BoQrXg0W0/WX9nrhvtwhLj
 2MvO/N7DBu+HzmwwZi7owCKRPHuPrgAVvaOOoMLD6UE7sup5T4lbJoMVnxTVWmWpj94X
 Y4CDslnc3t2B2KkoR2A1H/99fLCNBUb2e5sz7H45KvT0RTZ8uLLcZbW0CxmtLI1rcrSO
 rxJ1hKdelcuXw7h/yNWeCBqhjU/3zcCuJ/q7uJ59n6L1BElAT62+sbYySFSC6lPx+s+p fw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 2tq6qtg0hh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 15 Jul 2019 17:33:23 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6FHSSqb120414;
        Mon, 15 Jul 2019 17:33:20 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3030.oracle.com with ESMTP id 2tq4dten0h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 15 Jul 2019 17:33:19 +0000
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x6FHXEOP025118;
        Mon, 15 Jul 2019 17:33:14 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 15 Jul 2019 10:33:14 -0700
To:     Christoph Hellwig <hch@lst.de>
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Max Gurtovoy <maxg@mellanox.com>,
        Bart Van Assche <bvanassche@acm.org>,
        linux-rdma@vger.kernel.org, linux-scsi@vger.kernel.org,
        megaraidlinux.pdl@broadcom.com, MPT-FusionLinux.pdl@broadcom.com,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: properly communicate queue limits to the DMA layer v2
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <20190617122000.22181-1-hch@lst.de>
        <20190715165823.GA10029@lst.de>
Date:   Mon, 15 Jul 2019 13:33:11 -0400
In-Reply-To: <20190715165823.GA10029@lst.de> (Christoph Hellwig's message of
        "Mon, 15 Jul 2019 18:58:23 +0200")
Message-ID: <yq1tvbn2ofc.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1.92 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9319 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=619
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1907150204
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9319 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=686 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1907150204
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org


Christoph,

> Ping?  What happened to this set of bug fixes?

I thought they depended on Jens' tree?

-- 
Martin K. Petersen	Oracle Linux Engineering
