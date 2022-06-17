Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 716D054EF3B
	for <lists+linux-hyperv@lfdr.de>; Fri, 17 Jun 2022 04:21:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379683AbiFQCUf (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 16 Jun 2022 22:20:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232651AbiFQCUe (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 16 Jun 2022 22:20:34 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9981464BF6;
        Thu, 16 Jun 2022 19:20:31 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25H2FfQd029754;
        Fri, 17 Jun 2022 02:20:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2021-07-09;
 bh=JraEGcq645uaUTZHc2tASRhn8rvhQfMYW+IL7QF6ELI=;
 b=gUmt8KhukmpjSJSTSC2v39gg6OuTJ+RNef8IqdlAjvbtVfRxzsbN9+xulZvJEaxVq5C8
 bLiRiR0a3WRHQ3EKs3AePUyidKyjVp+IjVFOKF3mRcI2ZCjncAzCZgFkEG9HcYe660al
 CNBWGc7z7R3jdJ7Jh+EOYK2JywLU1wfUevyHfCYVu5cY+rL3Tqn3VK1w9YD81QvsOCdc
 UrAlqH4BKV6oVm5SivD0siSagakrihpAzsbUOGq8JNWyAeltdcds4A5jTmunpRrUst66
 jCzdzozBPdm2HRgdZcZaLsBWzCYfMKgGGqcWBCP4QNLHMnZMCycmhrIyCUvyUOvGj+xV Qg== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gmjx9mfn4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 17 Jun 2022 02:20:25 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 25H2GK9V038707;
        Fri, 17 Jun 2022 02:20:24 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3gpqq327eq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 17 Jun 2022 02:20:24 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 25H2KMSc006844;
        Fri, 17 Jun 2022 02:20:24 GMT
Received: from ca-mkp.mkp.ca.oracle.com (ca-mkp.ca.oracle.com [10.156.108.201])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3gpqq327d4-2;
        Fri, 17 Jun 2022 02:20:23 +0000
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
To:     haiyangz@microsoft.com,
        Saurabh Sengar <ssengar@linux.microsoft.com>,
        wei.liu@kernel.org, kys@microsoft.com,
        linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org,
        linux-scsi@vger.kernel.org, mikelley@microsoft.com,
        decui@microsoft.com, sthemmin@microsoft.com, jejb@linux.ibm.com,
        ssengar@microsoft.com
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>
Subject: Re: [PATCH v3] scsi: storvsc: Correct reporting of Hyper-V I/O size limits
Date:   Thu, 16 Jun 2022 22:20:19 -0400
Message-Id: <165543238454.26073.6374641443239965869.b4-ty@oracle.com>
X-Mailer: git-send-email 2.35.2
In-Reply-To: <1655190355-28722-1-git-send-email-ssengar@linux.microsoft.com>
References: <1655190355-28722-1-git-send-email-ssengar@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: HaMWH-0UJBwIz5X0lao9AB56iGqQIO3Q
X-Proofpoint-GUID: HaMWH-0UJBwIz5X0lao9AB56iGqQIO3Q
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Tue, 14 Jun 2022 00:05:55 -0700, Saurabh Sengar wrote:

> Current code is based on the idea that the max number of SGL entries
> also determines the max size of an I/O request.  While this idea was
> true in older versions of the storvsc driver when SGL entry length
> was limited to 4 Kbytes, commit 3d9c3dcc58e9 ("scsi: storvsc: Enable
> scatterlist entry lengths > 4Kbytes") removed that limitation. It's
> now theoretically possible for the block layer to send requests that
> exceed the maximum size supported by Hyper-V. This problem doesn't
> currently happen in practice because the block layer defaults to a
> 512 Kbyte maximum, while Hyper-V in Azure supports 2 Mbyte I/O sizes.
> But some future configuration of Hyper-V could have a smaller max I/O
> size, and the block layer could exceed that max.
> 
> [...]

Applied to 5.19/scsi-fixes, thanks!

[1/1] scsi: storvsc: Correct reporting of Hyper-V I/O size limits
      https://git.kernel.org/mkp/scsi/c/1d3e0980782f

-- 
Martin K. Petersen	Oracle Linux Engineering
