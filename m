Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F09EB533033
	for <lists+linux-hyperv@lfdr.de>; Tue, 24 May 2022 20:12:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240251AbiEXSMK (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 24 May 2022 14:12:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240241AbiEXSMB (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 24 May 2022 14:12:01 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6169606F9;
        Tue, 24 May 2022 11:12:00 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24OHnlBZ024134;
        Tue, 24 May 2022 18:11:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2021-07-09;
 bh=Y88LhOs828No2W/gspVvrN1GuqbQd9SVe0gokG2Lir0=;
 b=tWjvPI/zYsSwbUDmm+3g3hk3oU0+3xTVwgsabGjDkga38jsu2t0fHJKptwq+56tiGvge
 2ry0bsR1JOOr3ZfSaz+S4sYBHOnIneuSrm3b5NK4ErTcUKKnJ6v9YUzyz/1gefNEcadJ
 Q7p5dPrUnWfe0JvN4quMpsgc8EBYUVmYAE6yczexIR//eBE+x6rcZKQ4LTsuMMZGBAiC
 2Uuo/c9aEs9S7akQ5F9MFJAd/hVDEUNn+c2OuT2F9ls9/2bJEPLCoWZvkalhDvrMAxux
 uFICwsbshsMJzl/fhTug8Zqoi2pOR4QoG4OcecF3pYnPDZJd3l5HgEDeRMZCtzQ7OY6h xw== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3g93tbr3gn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 24 May 2022 18:11:50 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 24OHoItP016357;
        Tue, 24 May 2022 18:11:49 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3g93x50s6e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 24 May 2022 18:11:49 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 24OIAvnC039045;
        Tue, 24 May 2022 18:11:48 GMT
Received: from ca-mkp.mkp.ca.oracle.com (ca-mkp.ca.oracle.com [10.156.108.201])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3g93x50s3r-10;
        Tue, 24 May 2022 18:11:48 +0000
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
To:     Julia Lawall <Julia.Lawall@inria.fr>,
        "K. Y. Srinivasan" <kys@microsoft.com>
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Dexuan Cui <decui@microsoft.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        Wei Liu <wei.liu@kernel.org>, linux-hyperv@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>
Subject: Re: [PATCH] scsi: storvsc: fix typo in comment
Date:   Tue, 24 May 2022 14:11:42 -0400
Message-Id: <165341587529.22286.16208036407094767293.b4-ty@oracle.com>
X-Mailer: git-send-email 2.35.2
In-Reply-To: <20220521111145.81697-12-Julia.Lawall@inria.fr>
References: <20220521111145.81697-12-Julia.Lawall@inria.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: ws_kJOuBhbqcOwfGA_gInFEpgvlxfw3g
X-Proofpoint-ORIG-GUID: ws_kJOuBhbqcOwfGA_gInFEpgvlxfw3g
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Sat, 21 May 2022 13:10:22 +0200, Julia Lawall wrote:

> Spelling mistake (triple letters) in comment.
> Detected with the help of Coccinelle.
> 
> 

Applied to 5.19/scsi-queue, thanks!

[1/1] scsi: storvsc: fix typo in comment
      https://git.kernel.org/mkp/scsi/c/5445e08e1159

-- 
Martin K. Petersen	Oracle Linux Engineering
