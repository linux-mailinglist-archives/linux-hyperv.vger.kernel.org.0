Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 231ED76A17D
	for <lists+linux-hyperv@lfdr.de>; Mon, 31 Jul 2023 21:46:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230402AbjGaTqt (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 31 Jul 2023 15:46:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbjGaTqq (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 31 Jul 2023 15:46:46 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C2981BEB;
        Mon, 31 Jul 2023 12:46:27 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36VDTGus014514;
        Mon, 31 Jul 2023 19:46:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2023-03-30;
 bh=Mt2Tm0cL3p7FzoCtKe83LKwXpnN2Keuu76IOn6caZGc=;
 b=fLCRQRhS9i4H3FHuJRFzKNrgHxyEDjUR9JMuEzXq/4xRPbqOdiTyM/NE+5XBySguwdQL
 khBLEJUK59TWv2372uwUj/6aJ1+qi63lCkIrLIRZ8i0JNED4eBzXVhjS4KzUsa76pPdo
 81GaaKGIgO2DKwVXeeVHNvG06sRxho4CmhpoyaOX8wBVwEv9LtVgCrz3TSa7k1Ueu8Eo
 vJfSnxLXKlKSxFL3cLHhILDZdxfatizaZ7EfwC8GbT4t9LaOnZS70Ux2vlC9AiLETO+v
 1JuCmyPObRsBBEiJo7sDlCF7P931FVcFCWrp+f97EPaZCWCFHZuKFTK6kmxohcRD7tYS Uw== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3s4s6e3etk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 31 Jul 2023 19:46:22 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 36VIDI9M008921;
        Mon, 31 Jul 2023 19:46:21 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3s4s7bmuh0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 31 Jul 2023 19:46:21 +0000
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 36VJkKqC011875;
        Mon, 31 Jul 2023 19:46:20 GMT
Received: from ca-mkp2.ca.oracle.com.com (mpeterse-ol9.allregionaliads.osdevelopmeniad.oraclevcn.com [100.100.251.135])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3s4s7bmug6-2;
        Mon, 31 Jul 2023 19:46:20 +0000
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
To:     kys@microsoft.com, longli@microsoft.com, wei.liu@kernel.org,
        decui@microsoft.com, jejb@linux.ibm.com,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-scsi@vger.kernel.org, Michael Kelley <mikelley@microsoft.com>
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        stable@vger.kernel.org
Subject: Re: [PATCH 1/1] scsi: storvsc: Fix handling of virtual Fibre Channel timeouts
Date:   Mon, 31 Jul 2023 15:46:17 -0400
Message-Id: <169083273233.2873926.15195678771794220955.b4-ty@oracle.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <1690606764-79669-1-git-send-email-mikelley@microsoft.com>
References: <1690606764-79669-1-git-send-email-mikelley@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-31_13,2023-07-31_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 phishscore=0 mlxscore=0 adultscore=0 malwarescore=0 suspectscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307310179
X-Proofpoint-GUID: Qyi_B2rv0CDff3uljQQ2FVJz8mHQtLmg
X-Proofpoint-ORIG-GUID: Qyi_B2rv0CDff3uljQQ2FVJz8mHQtLmg
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Fri, 28 Jul 2023 21:59:24 -0700, Michael Kelley wrote:

> Hyper-V provides the ability to connect Fibre Channel LUNs to the host
> system and present them in a guest VM as a SCSI device. I/O to the vFC
> device is handled by the storvsc driver. The storvsc driver includes
> a partial integration with the FC transport implemented in the generic
> portion of the Linux SCSI subsystem so that FC attributes can be
> displayed in /sys.  However, the partial integration means that some
> aspects of vFC don't work properly. Unfortunately, a full and correct
> integration isn't practical because of limitations in what Hyper-V
> provides to the guest.
> 
> [...]

Applied to 6.5/scsi-fixes, thanks!

[1/1] scsi: storvsc: Fix handling of virtual Fibre Channel timeouts
      https://git.kernel.org/mkp/scsi/c/175544ad48cb

-- 
Martin K. Petersen	Oracle Linux Engineering
