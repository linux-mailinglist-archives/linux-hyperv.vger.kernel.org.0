Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E64F705CEE
	for <lists+linux-hyperv@lfdr.de>; Wed, 17 May 2023 04:14:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231489AbjEQCOU (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 16 May 2023 22:14:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231177AbjEQCOU (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 16 May 2023 22:14:20 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CC924EFF;
        Tue, 16 May 2023 19:13:44 -0700 (PDT)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34GJxWZR010649;
        Wed, 17 May 2023 02:13:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2023-03-30;
 bh=yd99+P9TOJhkp6wghOhZagzm2uRq5jgQIuT//cMAWPs=;
 b=g0RJ232fxZI3pHs81KfNUyxPOuKmxznxfzeHSx5JWgY0LeS4eyzQTZLeI96OdhR3vs17
 lv1FoT5BkQ4q+6oP44jUjwLrNwlYh1O7UdHYh+nB6v7h0WOUe6TJDRqzEO0t0T/GhOi6
 7nv3PoW2hTW5pzL+dYhHe69vTOfMN17LjsfuAVALoXqYvoH5ZDksW6e0p/X2FPyYLeZS
 gC4/42k3BKQTcjEnJb9SKt4nIS/T2M0SHx4xBC8/hhhukmi2MrVpuGyILkVIXizPsuPn
 gr1bXz7DhzGK5c1yRn24xt1F98GE5Vvryy+k8hcmlzUbGLDCetHSR81E8KN0paAhbXW6 iQ== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qj1fc4qhh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 17 May 2023 02:13:37 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 34GNBj72040050;
        Wed, 17 May 2023 02:13:36 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3qj104k9uy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 17 May 2023 02:13:36 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 34H29qF3039460;
        Wed, 17 May 2023 02:13:35 GMT
Received: from ca-mkp2.ca.oracle.com.com (mpeterse-ol9.allregionaliads.osdevelopmeniad.oraclevcn.com [100.100.251.135])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3qj104k9sf-2;
        Wed, 17 May 2023 02:13:35 +0000
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
To:     kys@microsoft.com, longli@microsoft.com, wei.liu@kernel.org,
        decui@microsoft.com, jejb@linux.ibm.com,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-scsi@vger.kernel.org, Michael Kelley <mikelley@microsoft.com>
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        stable@vger.kernel.org
Subject: Re: [PATCH 1/1] scsi: storvsc: Don't pass unused PFNs to Hyper-V host
Date:   Tue, 16 May 2023 22:13:26 -0400
Message-Id: <168428957880.722389.16586911622992063808.b4-ty@oracle.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <1684171241-16209-1-git-send-email-mikelley@microsoft.com>
References: <1684171241-16209-1-git-send-email-mikelley@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-16_14,2023-05-16_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0 bulkscore=0
 mlxscore=0 phishscore=0 malwarescore=0 spamscore=0 mlxlogscore=971
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2304280000
 definitions=main-2305170017
X-Proofpoint-ORIG-GUID: h0ZysJaUvviRhdem3zXn_8eGV9lkhfHI
X-Proofpoint-GUID: h0ZysJaUvviRhdem3zXn_8eGV9lkhfHI
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Mon, 15 May 2023 10:20:41 -0700, Michael Kelley wrote:

> In a SCSI request, storvsc pre-allocates space for up to
> MAX_PAGE_BUFFER_COUNT physical frame numbers to be passed to Hyper-V.
> If the size of the I/O request requires more PFNs, a separate memory
> area of exactly the correct size is dynamically allocated.
> 
> But when the pre-allocated area is used, current code always passes
> MAX_PAGE_BUFFER_COUNT PFNs to Hyper-V, even if fewer are needed.  While
> this doesn't break anything because the additional PFNs are always zero,
> more bytes than necessary are copied into the VMBus channel ring buffer.
> This takes CPU cycles and wastes space in the ring buffer. For a typical
> 4 Kbyte I/O that requires only a single PFN, 248 unnecessary bytes are
> copied.
> 
> [...]

Applied to 6.4/scsi-fixes, thanks!

[1/1] scsi: storvsc: Don't pass unused PFNs to Hyper-V host
      https://git.kernel.org/mkp/scsi/c/4e81a6cba517

-- 
Martin K. Petersen	Oracle Linux Engineering
