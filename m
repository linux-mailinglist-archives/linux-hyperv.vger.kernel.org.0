Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E8991B4DDD
	for <lists+linux-hyperv@lfdr.de>; Wed, 22 Apr 2020 21:59:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726512AbgDVT6i (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 22 Apr 2020 15:58:38 -0400
Received: from mail-dm6nam11on2109.outbound.protection.outlook.com ([40.107.223.109]:6625
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726380AbgDVT6i (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 22 Apr 2020 15:58:38 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DA+ehh3tPQ0Yi3G0CzR/g1+8yMOqHkzfgepW/4SIQbE7pGbxt/V3GenoxtLiEC7yJa7Vx/HdJbcGTzIDvWTzVL7Ms+588KCT2W0+v05mdZdcxW896XnixM33DnRPpsun53M4gTkeiEOGAqvtmZCjDf7NfjfDsm046sl012bc+9t41+JpvVxxapydRDBDtsnQgQfn9mMJOS2XBpFzU280Lz1NBeXv/vzhplGaZrT85dI1fLDlpKLHbwI8dt4GA/T/R8FJAKr5S1KLQ/6xmZHSsksd1wP8/sBjmqu8CXS/qyOngUyGPRI7mWLwPmPD9RV7hMWRnw6wY4nyxhn61SRmGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K/AVLmRdzyCxMOHHy2Y8kYout/ihcg0sWK74rWgP0tk=;
 b=D31wGoVB/Zn4GNDH+T6v6faJhRfuXBlQfEjpsQvDKX9lsPR3fpx5WQuOB0F0P7y1h7WQXXANgfuwrykoMgu2dbVxRKSVtSxO0IpDdi1xa3CbJqFU4Us1X7PwnqVjJ4DNM1W9ZFMoXjiVvOptCNO2QIMn0XIbf5TaLz+PWAgV948x/8gOeSIeLfH4dQ7aM+UNVcr94ZVKVT48+URQFCaTbHc5FZmDC8WX18fZlXgcNa602Ekh9Zp3hCEf92z/briZPXlySEvEs5zG0nQdGNP1BupF+VpV1OYxDCb3cRUjZGUSToHt1fJoPGIhj44zVGMcmLXK8KuT4Z/brOrriYBMXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K/AVLmRdzyCxMOHHy2Y8kYout/ihcg0sWK74rWgP0tk=;
 b=VbmCpBhdfY1vgg6qf6yqKtVipQcPO7y7oAAomsixPOUPlOIBkpc2tdTxRu15YFzcRe7/9O6f5v+bnwBPkej/Svff1/dDpdS5s7/jdUYr6QuMCo5vl6SvU1DL8ik5Sz4sIbS51KZQxwbtgbClYnaEAldYC2b7PjkM7Rp1M4zcnv4=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=mikelley@microsoft.com; 
Received: from BN6PR21MB0178.namprd21.prod.outlook.com (2603:10b6:404:94::12)
 by BN6PR21MB0148.namprd21.prod.outlook.com (2603:10b6:404:93::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.2; Wed, 22 Apr
 2020 19:58:34 +0000
Received: from BN6PR21MB0178.namprd21.prod.outlook.com
 ([fe80::a97c:360c:9ed2:12ec]) by BN6PR21MB0178.namprd21.prod.outlook.com
 ([fe80::a97c:360c:9ed2:12ec%11]) with mapi id 15.20.2958.001; Wed, 22 Apr
 2020 19:58:34 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        wei.liu@kernel.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, x86@kernel.org, hpa@zytor.com, pbonzini@redhat.com,
        sean.j.christopherson@intel.com, vkuznets@redhat.com,
        wanpengli@tencent.com, jmattson@google.com, joro@8bytes.org,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hyperv@vger.kernel.org
Cc:     mikelley@microsoft.com
Subject: [PATCH v2 0/4] Split hyperv-tlfs.h into generic and arch specific files
Date:   Wed, 22 Apr 2020 12:57:33 -0700
Message-Id: <20200422195737.10223-1-mikelley@microsoft.com>
X-Mailer: git-send-email 2.18.2
Content-Type: text/plain
X-ClientProxiedBy: MWHPR19CA0078.namprd19.prod.outlook.com
 (2603:10b6:320:1f::16) To BN6PR21MB0178.namprd21.prod.outlook.com
 (2603:10b6:404:94::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from MHKdev.corp.microsoft.com (167.220.2.108) by MWHPR19CA0078.namprd19.prod.outlook.com (2603:10b6:320:1f::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.13 via Frontend Transport; Wed, 22 Apr 2020 19:58:32 +0000
X-Mailer: git-send-email 2.18.2
X-Originating-IP: [167.220.2.108]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 6672d878-4d91-4111-2943-08d7e6f78a17
X-MS-TrafficTypeDiagnostic: BN6PR21MB0148:|BN6PR21MB0148:|BN6PR21MB0148:
X-MS-Exchange-Transport-Forked: True
X-LD-Processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
X-Microsoft-Antispam-PRVS: <BN6PR21MB0148D71E3BFC1A20DCC127E7D7D20@BN6PR21MB0148.namprd21.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-Forefront-PRVS: 03818C953D
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR21MB0178.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(346002)(136003)(396003)(366004)(376002)(39860400002)(81156014)(82960400001)(8936002)(10290500003)(4326008)(26005)(82950400001)(5660300002)(107886003)(956004)(2616005)(478600001)(66556008)(66946007)(66476007)(6486002)(1076003)(86362001)(316002)(8676002)(2906002)(16526019)(186003)(36756003)(52116002)(7696005)(7416002)(41533002)(921003);DIR:OUT;SFP:1102;
Received-SPF: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UnyelGc10ZdLFjXmVQ9c3MIg5hDWMbiVhRo81RRdDi0+3kp4V4XBytlSH+UDeoOxsDPtZP4vNR+fJtwysEovW+2Fu3cOooYRx+H6LrQ5wtZGxz+P9LwKjNkzO+8tRQALQKYJxUmBHKoZCCpUnSFH6gbJgl4rWDLbripIF5YCgxHcs4hvDXVCZP5CryxZY2A9JNdDM3irg7kN2Aa9fOmcSPd+6B/wvqr5LUzZMsQCbXutogHVbdpBNbYV/Qw+DkUeXC95yNw+scGWd7zB+ei2GuIOmkrmhfPxtaRr11krIOWjrne09E7QRHG89wLWV3LimUPWxfdzVGrUBe8nboZ8FFH0q/YKySYIP47E3up4EvIIVpoklnbruxEXfBuORxY91MYmLiegRy1zWkGgGjlnsxXXTauxUUPrFEDokm87b92alaxDcR9LF2sqgyqi+aHZYbzudUqVRQ5Sy5cmprkqOh2+cxzSStDuV2s1Ano8/KKmeGGft2LrbuYdjYM5tW03
X-MS-Exchange-AntiSpam-MessageData: Bk4DO3Xs7JfFvCHGn20ME44TPd6dALa70cubwbNQWnTeCzpruSWgM6vugvzJSDBNDQE2EBgAxFJOI7u4hPMtcQDzjxwmPntQ8PIY2yD+jFHgMLEpo8ycjP+npm9C+GmGi2+EEAQfelKpjVdnNr56z/xGz8gXYXSEWQm/kQi/p4sW1sHedI52pxbV5HO5+rxpjZEVNzfssLayWkr13WIH20aeDnT74bgJtC1A0TVSTnjE1VhgPsXl2XML3KRJ3oVnM1WosI4U8EZ4roNLqSDh+Ymex7mSx+Ku7FAQqefqEosf1ta7HC7SF/JteYMm22jZTppsUT4wcw46inK4pg8LiN7ZcLvA0p/iGUPBidw8JwqsBMGbm26F8cXh3G+N4+XQGwAki5FeE2PGkitQwEEXrkvJDoH041i1cjryA3XuLfKLB5sIdI3LgXy+ZwZn+GUby5/tkfTim2uJj8ndzmKNotcwhYczTJH4PWlmn0oQ3TQirua4mI20x+zjYUZJQo+nzU7vPnNt2OqSx8kClaD5RHrA0uXg1M3IQanWkVzWfsym29h/o5/34jA90Ny5Qp6senTcKNVFtH2lj3h5KIiNjSRPxxMA6IVdoCxWevB1bUmEjI59n6sp3/zQipHDEaNTwToDSlw5n4TtaiR/1hE7xmBRKAAA2XDgDQSvPnGwtqCrljqy2UXBZOVM6SZRgMeuIK5Q52b9mA0KKpwHSmQ15Pa2+nAJU81NsGBqrRREN1JyZWpthVaYGItsa4bQs6IXxni8cBxjggrSpJoeWijuNkNrDf6MxBiIkf1p5KzlZVM=
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6672d878-4d91-4111-2943-08d7e6f78a17
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2020 19:58:34.6637
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: R+GUTL3f+uQ/v0SqGcPGpq3DETVK+RGtlvQwhW7ldgcUc0dg0lKudW9uBM6JghBPVHrH8sK65Yy/EJKnTm7qSQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR21MB0148
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

This series splits hyperv-tlfs.h into architecture independent and
architecture specific files so that the arch independent portion can
be shared between the x86/x64 and ARM64 code for Hyper-V.  While the
Hyper-V team has not released a version of the TLFS document that
clearly specifies which portions of the interface are arch independent,
we can make a fairly good assessment based on implementation work done
to support Linux guests on Hyper-V on ARM64, and on private communication
with the Hyper-V team.  Definitions are considered arch independent if
they are implemented by Hyper-V on both architectures (x86/x64 and ARM64),
even if they are currently needed by Linux code only on one architecture.

Many definitions in hyperv-tlfs.h have historically contained "X64" in the
name, which doesn't make sense for architecture independent definitions.
While many of the occurrences of "X64" have already been removed, some
still remain in definitions that should be arch independent. The
split removes the "X64" from the definitions so that the arch
independent hyper-tlfs.h has no occurrences of "X64". However, to
keep this patch set separate from a wider change in the names, aliases
are added in the x86/x64 specific hyperv-tlfs.h so that existing code
continues to compile.  The definitions can be fixed throughout the code
in a more incremental fashion in separate patches, and then the aliases
can be removed.

Where it is not clear if definitions are arch independent, they have been
kept in the x86/x64 specific file. The Hyper-V team is aiming to have a
version of the TLFS document covering ARM64 by the end of calendar 2020,
so additional definitions may be moved into the arch independent portion
after the new TLFS document is released.

The first two patches in the series clean up the existing hyperv-tlfs.h
file a bit by removing duplicate or unnecessary definitions so they are
not propagated across the split. The third patch does the split, and the
fourth patch adds new definitions that are needed on ARM64 but are generic.

These changes have no functional impact.

These patches are built against linux-next-20200415

---

Changes in v2:
* Improved definitions for Get/SetVpRegisters hypercalls in
  include/asm-generic/hyperv-tlfs.h in Patch 4 [Vitaly Kuznetsov]
* Updated MAINTAINERS with new file in Patch 3


Michael Kelley (4):
  KVM: x86: hyperv: Remove duplicate definitions of Reference TSC Page
  x86/hyperv: Remove HV_PROCESSOR_POWER_STATE #defines
  x86/hyperv: Split hyperv-tlfs.h into arch dependent and independent
    files
  asm-generic/hyperv: Add definitions for Get/SetVpRegister hypercalls

 MAINTAINERS                        |   1 +
 arch/x86/include/asm/hyperv-tlfs.h | 472 +++------------------------
 arch/x86/include/asm/kvm_host.h    |   2 +-
 arch/x86/kvm/hyperv.c              |   4 +-
 include/asm-generic/hyperv-tlfs.h  | 493 +++++++++++++++++++++++++++++
 5 files changed, 533 insertions(+), 439 deletions(-)
 create mode 100644 include/asm-generic/hyperv-tlfs.h

-- 
2.18.2

