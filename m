Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 204182798E2
	for <lists+linux-hyperv@lfdr.de>; Sat, 26 Sep 2020 14:39:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728466AbgIZMjs (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Sat, 26 Sep 2020 08:39:48 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:11546 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726183AbgIZMjr (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Sat, 26 Sep 2020 08:39:47 -0400
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 08QCWRe0111727;
        Sat, 26 Sep 2020 08:39:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=3MYKY040lEuw5jDKzV3PF147mCVYwbqY92Kcs2d9pHM=;
 b=stYoAHM4Idv9dsIru0fmgGg81Du4QTVpzAy3h7TyNOJeQLokKMLrJqIE4dCviuU9KwBb
 IsZSYnrpNZ+wsMMBawyZaunEhq0onbMYGNEe3hcH/FWrMyy7MwDtDDOGWflQ+m9zqGz8
 SsbpFbkp1/Tpa5IRfDPQPQ7KG60pXTMaQXHCKb/xbK9mrXkL4uqw+1nFonDjSDncarcQ
 Is+gIoez8CG1++CbuoWEy2GgeDRN8bzXXmZFe5+IyxB5C1JmLB1TjPvIbd2hJGmhxXuy
 1EErU5N4KtdBp5+VG58W6XUpLKMHS7LRSJzpbkuYAontzSSvj8OuNtPZc3DTB00JxD2Z iA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 33t5er8cv1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 26 Sep 2020 08:39:04 -0400
Received: from m0187473.ppops.net (m0187473.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 08QCWWxS111972;
        Sat, 26 Sep 2020 08:39:03 -0400
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 33t5er8cuc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 26 Sep 2020 08:39:03 -0400
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 08QCRuOI023314;
        Sat, 26 Sep 2020 12:39:00 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma03ams.nl.ibm.com with ESMTP id 33sw980bk9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 26 Sep 2020 12:39:00 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 08QCcva320513094
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 26 Sep 2020 12:38:57 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 57D25A4040;
        Sat, 26 Sep 2020 12:38:57 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 36400A4057;
        Sat, 26 Sep 2020 12:38:55 +0000 (GMT)
Received: from localhost (unknown [9.145.18.16])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Sat, 26 Sep 2020 12:38:55 +0000 (GMT)
Date:   Sat, 26 Sep 2020 14:38:53 +0200
From:   Vasily Gorbik <gor@linux.ibm.com>
To:     Thomas Gleixner <tglx@linutronix.de>, Qian Cai <cai@redhat.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Heiko Carstens <hca@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        linux-s390@vger.kernel.org,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        linux-next@vger.kernel.org, x86@kernel.org,
        Joerg Roedel <joro@8bytes.org>,
        iommu@lists.linux-foundation.org, linux-hyperv@vger.kernel.org,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Jon Derrick <jonathan.derrick@intel.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Wei Liu <wei.liu@kernel.org>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Steve Wahl <steve.wahl@hpe.com>,
        Dimitri Sivanich <sivanich@hpe.com>,
        Russ Anderson <rja@hpe.com>, linux-pci@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        xen-devel@lists.xenproject.org, Juergen Gross <jgross@suse.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Marc Zyngier <maz@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Megha Dey <megha.dey@intel.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Jacob Pan <jacob.jun.pan@intel.com>,
        Baolu Lu <baolu.lu@intel.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Dan Williams <dan.j.williams@intel.com>
Subject: Re: [patch V2 34/46] PCI/MSI: Make arch_.*_msi_irq[s] fallbacks
 selectable
Message-ID: <your-ad-here.call-01601123933-ext-6476@work.hours>
References: <20200826111628.794979401@linutronix.de>
 <20200826112333.992429909@linutronix.de>
 <cdfd63305caa57785b0925dd24c0711ea02c8527.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cdfd63305caa57785b0925dd24c0711ea02c8527.camel@redhat.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-26_10:2020-09-24,2020-09-26 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 impostorscore=0
 adultscore=0 priorityscore=1501 phishscore=0 mlxlogscore=948
 suspectscore=0 mlxscore=0 bulkscore=0 malwarescore=0 spamscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009260111
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Fri, Sep 25, 2020 at 09:54:52AM -0400, Qian Cai wrote:
> On Wed, 2020-08-26 at 13:17 +0200, Thomas Gleixner wrote:
> > From: Thomas Gleixner <tglx@linutronix.de>
> > 
> > The arch_.*_msi_irq[s] fallbacks are compiled in whether an architecture
> > requires them or not. Architectures which are fully utilizing hierarchical
> > irq domains should never call into that code.
> > 
> > It's not only architectures which depend on that by implementing one or
> > more of the weak functions, there is also a bunch of drivers which relies
> > on the weak functions which invoke msi_controller::setup_irq[s] and
> > msi_controller::teardown_irq.
> > 
> > Make the architectures and drivers which rely on them select them in Kconfig
> > and if not selected replace them by stub functions which emit a warning and
> > fail the PCI/MSI interrupt allocation.
> > 
> > Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> 
> Today's linux-next will have some warnings on s390x:
> 
> .config: https://gitlab.com/cailca/linux-mm/-/blob/master/s390.config
> 
> WARNING: unmet direct dependencies detected for PCI_MSI_ARCH_FALLBACKS
>   Depends on [n]: PCI [=n]
>   Selected by [y]:
>   - S390 [=y]
> 
> WARNING: unmet direct dependencies detected for PCI_MSI_ARCH_FALLBACKS
>   Depends on [n]: PCI [=n]
>   Selected by [y]:
>   - S390 [=y]
>

Yes, as well as on mips and sparc which also don't FORCE_PCI.
This seems to work for s390:

diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
index b0b7acf07eb8..41136fbe909b 100644
--- a/arch/s390/Kconfig
+++ b/arch/s390/Kconfig
@@ -192,3 +192,3 @@ config S390
        select PCI_MSI                  if PCI
-       select PCI_MSI_ARCH_FALLBACKS
+       select PCI_MSI_ARCH_FALLBACKS   if PCI
        select SET_FS
