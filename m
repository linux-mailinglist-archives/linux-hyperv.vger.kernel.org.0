Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF1E1730D11
	for <lists+linux-hyperv@lfdr.de>; Thu, 15 Jun 2023 04:16:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238346AbjFOCQg (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 14 Jun 2023 22:16:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238267AbjFOCQf (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 14 Jun 2023 22:16:35 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26FA91BEC;
        Wed, 14 Jun 2023 19:16:35 -0700 (PDT)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35EJcZmV009944;
        Thu, 15 Jun 2023 02:15:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2023-03-30;
 bh=nUbXpebNc5HuZ9sdR+OhaecOaaP7FE3N3bodrbFXLS8=;
 b=jqZRW1WRza9j4NXa1/Aty667+bZhE+DH2jepOTUrNWbEpbIVtNUs+3cw/tBC+/ih2ymF
 K1vCqjJ/HRg6M56NYnY+blg8Bq9wQi70bsccDMwOyK70AsYJA0O/di88R3Pis1AqM3zl
 dBR+ROT3fadzZ/EZDrIbUXeqMIpq/R5C5gYBBwrLfaqnAngq8Sk21MaAWcIqJbOzhHhT
 0X9uqDaxyBI0tNmirBNBkwDRz02CH+/92+VSF77PieGMGn132uADf7wjOJCyChRcfvag
 jsMaJrQwYUyc/l53oHRkpnISeKMPFZ6sb5k6i2/uVZAb6U2Jsnmt828NVkTJPmu8RFVK Lw== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3r4g3bs1fq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 15 Jun 2023 02:15:43 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 35F1FmFj008399;
        Thu, 15 Jun 2023 02:15:42 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3r4fmcm0ht-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 15 Jun 2023 02:15:42 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 35F2FfSv031296;
        Thu, 15 Jun 2023 02:15:41 GMT
Received: from ca-mkp2.ca.oracle.com.com (mpeterse-ol9.allregionaliads.osdevelopmeniad.oraclevcn.com [100.100.251.135])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3r4fmcm0h8-2;
        Thu, 15 Jun 2023 02:15:41 +0000
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
To:     kys@microsoft.com, longli@microsoft.com, wei.liu@kernel.org,
        decui@microsoft.com, jejb@linux.ibm.com,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-scsi@vger.kernel.org, Michael Kelley <mikelley@microsoft.com>
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>
Subject: Re: [PATCH 1/1] scsi: storvsc: Always set no_report_opcodes
Date:   Wed, 14 Jun 2023 22:15:32 -0400
Message-Id: <168679530533.3778443.1192688670908894213.b4-ty@oracle.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <1686343101-18930-1-git-send-email-mikelley@microsoft.com>
References: <1686343101-18930-1-git-send-email-mikelley@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-14_14,2023-06-14_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=934 phishscore=0
 malwarescore=0 mlxscore=0 adultscore=0 bulkscore=0 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306150017
X-Proofpoint-ORIG-GUID: 4W3DeEKV7HP2NHfD2gHlntszRvld73W0
X-Proofpoint-GUID: 4W3DeEKV7HP2NHfD2gHlntszRvld73W0
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Fri, 09 Jun 2023 13:38:21 -0700, Michael Kelley wrote:

> Hyper-V synthetic SCSI devices do not support the MAINTENANCE_IN SCSI
> command, so scsi_report_opcode() always fails, resulting in messages
> like this:
> 
> hv_storvsc <guid>: tag#205 cmd 0xa3 status: scsi 0x2 srb 0x86 hv 0xc0000001
> 
> The recently added support for command duration limits calls
> scsi_report_opcode() four times as each device comes online, which
> significantly increases the number of messages logged in a system with
> many disks.
> 
> [...]

Applied to 6.4/scsi-fixes, thanks!

[1/1] scsi: storvsc: Always set no_report_opcodes
      https://git.kernel.org/mkp/scsi/c/31d16e712bdc

-- 
Martin K. Petersen	Oracle Linux Engineering
