Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DE78260903
	for <lists+linux-hyperv@lfdr.de>; Tue,  8 Sep 2020 05:40:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728430AbgIHDkX (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 7 Sep 2020 23:40:23 -0400
Received: from mx0a-002e3701.pphosted.com ([148.163.147.86]:24192 "EHLO
        mx0a-002e3701.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728317AbgIHDkW (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 7 Sep 2020 23:40:22 -0400
Received: from pps.filterd (m0134421.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0883aMVq002464;
        Tue, 8 Sep 2020 03:39:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=date : from : to : cc :
 subject : message-id : reply-to : references : mime-version : content-type
 : in-reply-to; s=pps0720; bh=A+udrY24FFEXs0nTcdNmz7GYM1C5dz0HSK7tP/+BXaI=;
 b=JiPCnGEd9SOLp4EP4cJa6ucsY7RvDBYxzgctn9V6k1a3zSf3vCNMHPZcYHHrSrjlYWkj
 8DHLbpKGNLPjpdC/pBgqp+XpX332TSU43M8KhriEqLAWC5SSnFtckELRz/988CF1Ctkd
 ACrZKVFIRGr3poHavXO8vE2oQJRP9uxAAaTNTH1nrkvshTZkm7/7X982mVK2iLmDRcFa
 uhfp0pn8zyJnJymJd32OZeryBNo40l7hWZq7gd+tS5hRDjDv6Z+uZPcK+nYCdj/etzt+
 oFghpCKwnGAezLze65XCNk/WQDWo1dQqo4khY5vTwlCJDiHO4hN1T/suUScEZCMMdDne XQ== 
Received: from g9t5009.houston.hpe.com (g9t5009.houston.hpe.com [15.241.48.73])
        by mx0b-002e3701.pphosted.com with ESMTP id 33cm1x736d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 08 Sep 2020 03:39:40 +0000
Received: from g4t3433.houston.hpecorp.net (g4t3433.houston.hpecorp.net [16.208.49.245])
        by g9t5009.houston.hpe.com (Postfix) with ESMTP id 87D0E51;
        Tue,  8 Sep 2020 03:39:38 +0000 (UTC)
Received: from hpe.com (ben.americas.hpqcorp.net [10.33.153.7])
        by g4t3433.houston.hpecorp.net (Postfix) with ESMTP id 6C95948;
        Tue,  8 Sep 2020 03:39:36 +0000 (UTC)
Date:   Mon, 7 Sep 2020 22:39:36 -0500
From:   Russ Anderson <rja@hpe.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Joerg Roedel <joro@8bytes.org>,
        iommu@lists.linux-foundation.org, linux-hyperv@vger.kernel.org,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Jon Derrick <jonathan.derrick@intel.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Wei Liu <wei.liu@kernel.org>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Steve Wahl <steve.wahl@hpe.com>,
        Dimitri Sivanich <sivanich@hpe.com>, linux-pci@vger.kernel.org,
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
Subject: Re: [patch V2 00/46] x86, PCI, XEN, genirq ...: Prepare for device
 MSI
Message-ID: <20200908033936.sbbbjvxsavr2j3rr@hpe.com>
Reply-To: Russ Anderson <rja@hpe.com>
References: <20200826111628.794979401@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200826111628.794979401@linutronix.de>
User-Agent: NeoMutt/20170421 (1.8.2)
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-08_02:2020-09-07,2020-09-08 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 malwarescore=0 phishscore=0 lowpriorityscore=0 spamscore=0 mlxlogscore=580
 bulkscore=0 priorityscore=1501 adultscore=0 clxscore=1011 mlxscore=0
 suspectscore=2 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009080032
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Wed, Aug 26, 2020 at 01:16:28PM +0200, Thomas Gleixner wrote:
> This is the second version of providing a base to support device MSI (non
> PCI based) and on top of that support for IMS (Interrupt Message Storm)
> based devices in a halfways architecture independent way.

Booted with quick testing on a 32 socket, 1536 CPU, 12 TB memory
Cascade Lake system and a 8 socket, 144 CPU, 3 TB memory
Cooper Lake system without any obvious regression.


-- 
Russ Anderson,  SuperDome Flex Linux Kernel Group Manager
HPE - Hewlett Packard Enterprise (formerly SGI)  rja@hpe.com
