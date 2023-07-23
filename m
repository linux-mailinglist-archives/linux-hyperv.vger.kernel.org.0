Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E16D75E4F1
	for <lists+linux-hyperv@lfdr.de>; Sun, 23 Jul 2023 22:42:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229883AbjGWUmy (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Sun, 23 Jul 2023 16:42:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbjGWUmx (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Sun, 23 Jul 2023 16:42:53 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDC0EE49;
        Sun, 23 Jul 2023 13:42:52 -0700 (PDT)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36NK38dA008143;
        Sun, 23 Jul 2023 20:42:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2023-03-30;
 bh=tWB/Ln2fHRti3fgWdutxcHqU2wau1O+b4SceuLCMeyE=;
 b=YZjOBV2213gdcPvFkiiG5jdRQhVEyk6qg7MI2sJC82UPSZzQmQzJKQBAeRMvYJua1d0x
 nj6gu5HbsHF8i4CT3JH9j8w6yZtXBtrDy/Y8hx1l8VV9gp8E8dD9oiOZ81RCi7eEp3Pp
 oHZ5U81BpCjgKYbB8RZNGDWnMBrWuX2TCz/yDeg4y5pGodg/PB/F7C5d25psXaS4fuYv
 4HZU0IaxpyPY3F37wpci2L77K26b36Al6FW0JWMqMO8uqPYHp8LkJmMYQomq0A0xtbAa
 tM/a6jEBkC/rMaZGKsdB0RpdKSUrhCEzdVWW6l2VfoZu1mBaLdtM+8kIlGowced1b0hK 7Q== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3s061c1j3u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 23 Jul 2023 20:42:47 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 36NJka2c028198;
        Sun, 23 Jul 2023 20:42:45 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3s05j8y5dg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 23 Jul 2023 20:42:45 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 36NKgjNL029256;
        Sun, 23 Jul 2023 20:42:45 GMT
Received: from ca-mkp2.ca.oracle.com.com (mpeterse-ol9.allregionaliads.osdevelopmeniad.oraclevcn.com [100.100.251.135])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3s05j8y5da-1;
        Sun, 23 Jul 2023 20:42:45 +0000
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
To:     kys@microsoft.com, longli@microsoft.com, wei.liu@kernel.org,
        decui@microsoft.com, jejb@linux.ibm.com,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-scsi@vger.kernel.org, Michael Kelley <mikelley@microsoft.com>
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        stable@vger.kernel.org
Subject: Re: [PATCH 1/1] scsi: storvsc: Limit max_sectors for virtual Fibre Channel devices
Date:   Sun, 23 Jul 2023 16:42:39 -0400
Message-Id: <169014494336.1846781.4528365743550446622.b4-ty@oracle.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <1689887102-32806-1-git-send-email-mikelley@microsoft.com>
References: <1689887102-32806-1-git-send-email-mikelley@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-23_08,2023-07-20_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 bulkscore=0
 mlxlogscore=879 suspectscore=0 phishscore=0 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2307230194
X-Proofpoint-ORIG-GUID: UOJ5JPdJO42NUePP8ExAvQk1O6YgtFTu
X-Proofpoint-GUID: UOJ5JPdJO42NUePP8ExAvQk1O6YgtFTu
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Thu, 20 Jul 2023 14:05:02 -0700, Michael Kelley wrote:

> The Hyper-V host is queried to get the max transfer size that it
> supports, and this value is used to set max_sectors for the synthetic
> SCSI controller.  However, this max transfer size may be too large
> for virtual Fibre Channel devices, which are limited to 512 Kbytes.
> If a larger transfer size is used with a vFC device, Hyper-V always
> returns an error, and storvsc logs a message like this where the SRB
> status and SCSI status are both zero:
> 
> [...]

Applied to 6.5/scsi-fixes, thanks!

[1/1] scsi: storvsc: Limit max_sectors for virtual Fibre Channel devices
      https://git.kernel.org/mkp/scsi/c/010c1e1c5741

-- 
Martin K. Petersen	Oracle Linux Engineering
