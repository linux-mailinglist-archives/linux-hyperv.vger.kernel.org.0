Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A627426F6C
	for <lists+linux-hyperv@lfdr.de>; Fri,  8 Oct 2021 19:19:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231215AbhJHRVx (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 8 Oct 2021 13:21:53 -0400
Received: from mail-oln040093003002.outbound.protection.outlook.com ([40.93.3.2]:19149
        "EHLO na01-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229606AbhJHRVx (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 8 Oct 2021 13:21:53 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CXXIDgByzRHS2odzJ/AtcaAnBsoHxXooRCmbWI4KZTqb2AePfRuOvk0tqO1xc8/obgZ/idmNNSDRf3FMi2WGKjVWjdfeD+Xt2OI+s2/+FnSFEdlkSmR7fvPn++sn/h7Rmhi1uXhOX+Md97RZ9ZoaFZ76SZ6evidSiogG13Cn0Aj9eGC8ju1+jNE8JTaAnYOVyi13aW2cu5PozRqtNBZZR/DGUXfyqD3QSn8Q5g1t1YTsn6aivMjL17oDkmGNyjB/E/gMGgekh27mEtP6FEaB0jKZj7R8XS4OS/u+y3gV9EaK5oAi1HnknxF3msNYvyc4Kj4sv7VVyE1xgzfkGkE0RA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AIWI9usN7Wtk7PeGlgiXa3+a5hwHulxPebracARxzNk=;
 b=nG12siMC6DVwDY0yTRIr5b1z5JG+qP3VXhL9UPjq0PS6rjQLVN7czaKhTwBLgJoQk12xKUPYiTA8Py6puCyBUqnD4l7UC0QNxVnY+u8IAG1mXTpA0ZD8dHj5G4xlOpydUOPcDDBLDqpw5N8Nuwe+uryPyk72xFSMjyLwuojPG1cWCPbBHD5w22unr+OzrYqDWL+V5XpR+D9FZ7YmD97g1sQMQQt+cplSdbA70jwCf3GngIeVnO9khFNAagO1lmAYWPzlQH97NuVpVnavZpOv+rl+Yd7OpZPDXdXCTES7m6WsaLl2qMPN9xwlxSjz2OvZ+9zugDyOuKutD4sNlO1hWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AIWI9usN7Wtk7PeGlgiXa3+a5hwHulxPebracARxzNk=;
 b=Y2LqBWk+GP96/WQplWgmBsgmtGnJLoireLzA1+Sl3EH0RytS1lesixv/G4ZBgoUzRVo+y5CsLwKGSJs7lzMAtOHAi2h07McipSmONzz/0l1ABPh10EhO6xuKZ0ue6E1R1gVODh5ehgkXM74N2RunRL8AfN8nFzvbZVRYiVYsBEE=
Received: from MW4PR21MB2002.namprd21.prod.outlook.com (2603:10b6:303:68::18)
 by MW2PR2101MB1851.namprd21.prod.outlook.com (2603:10b6:302:c::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.1; Fri, 8 Oct
 2021 17:19:53 +0000
Received: from MW4PR21MB2002.namprd21.prod.outlook.com
 ([fe80::89fe:5bf:5eb2:4c55]) by MW4PR21MB2002.namprd21.prod.outlook.com
 ([fe80::89fe:5bf:5eb2:4c55%4]) with mapi id 15.20.4608.008; Fri, 8 Oct 2021
 17:19:53 +0000
From:   Sunil Muthuswamy <sunilmut@microsoft.com>
To:     Marc Zyngier <maz@kernel.org>,
        Michael Kelley <mikelley@microsoft.com>,
        Boqun Feng <Boqun.Feng@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Dexuan Cui <decui@microsoft.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        =?iso-8859-2?Q?=22Krzysztof_Wilczy=F1ski=22?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Wei Liu <wei.liu@kernel.org>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "\"H. Peter Anvin\"" <hpa@zytor.com>,
        Arnd Bergmann <arnd@arndb.de>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 0/2] PCI: hv: Hyper-V vPCI for ARM64
Thread-Topic: [PATCH v2 0/2] PCI: hv: Hyper-V vPCI for ARM64
Thread-Index: Ade8Z9t+jRUuLsS9S2C/sb8+Gj5obw==
Date:   Fri, 8 Oct 2021 17:19:53 +0000
Message-ID: <MW4PR21MB200217CCFBC351FD12D68DF0C0B29@MW4PR21MB2002.namprd21.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=0a970baf-4191-44cf-9a6b-38ca92bcc987;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2021-10-08T17:08:01Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 39e0218e-c9e7-4d21-d083-08d98a7fd800
x-ms-traffictypediagnostic: MW2PR2101MB1851:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MW2PR2101MB18513E2DDA1B933885312A90C0B29@MW2PR2101MB1851.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1013;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lYFfeeO4JmkO0F8jD3LYxmSfpTl1vOeVzRbyDmRwIr7GY4EaZ51i3HP/t64l/YxaQbsgy6qcLG4LU2aQBucGWmRdFpR68K/zNwHpIP1+KbOkCaOyi6xTCBj7XlGbGUsJRoh1aHo+pjw/xYJ5099Jn2bcOKJ9T7XjVA8O6Sx7pudfVsjR1TshwIG4zjCJsEGdIp0wIM8W7nOGP3kW4CIkZKMnTUEhLHJsFimJJyfYBC9X6ySzVVNJIm3Qmmq05GZvYB9vIrRBPj+EBLrdsdgUADxJZwSnRzi+qBtFIfDDrwm/bAySllIqHOmncuE0O9FWcJQO7eKhu9GnHe2quo2BQtuvrn7wHOIuR0VGSpcYPInCPxVHnsMC/XTCMgDx3CsYWOM8w+F4qPhW+KxSRvEFSfisYLwkSE/qARMiSwktaZaFLgvEwwUx2nLkSPGaLC6Hl+HRer/ZEbqABdeC72gow/pVyg26pXM8BKunhiLKAccEf2qBqUGECq+N8aBscL38ufKysDuzzFEnb0yUF0z9avRcWPNykaGCYcyYJyecG/UYDSkemVykUCZBw0NrPuHKYEm/D/Ae9JmvaIlRGvb06nH+QKSxBObfAbjLi+yFaeMO9GTchW/fejN3U5RJzO5Z6YitMpUlqNbFS8PMk6t8sLd7UYnEpTDetNW8Vjuczd34NSsMBS8Al+fNYGi+kQeu6GgH8L84Q3xDQNdPPT9t1LJqHChptq9SepwInnB4Rmc=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR21MB2002.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(66476007)(64756008)(66446008)(2906002)(8676002)(66556008)(66946007)(82960400001)(71200400001)(33656002)(55016002)(52536014)(122000001)(38100700002)(86362001)(186003)(9686003)(82950400001)(76116006)(8990500004)(921005)(4326008)(38070700005)(110136005)(8936002)(316002)(83380400001)(5660300002)(54906003)(508600001)(10290500003)(7696005)(6506007)(7416002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-2?Q?nDaXAsFHdzmW3uR88KefPjKkKaQRPZFIrq5RfpGX9TvDhMdpg2VQutLme4?=
 =?iso-8859-2?Q?TaCu7nMj5oYRQ9oNnIPCkTlpcGxrUx8r/SKBxCyS//gJBncnJc0wdTrEdR?=
 =?iso-8859-2?Q?+wYHdzsa4Wb64q7/UMxd/MI/+ctuLoTYxaY+jPAsQuitbS1/8Fxjc92jEr?=
 =?iso-8859-2?Q?XFjTvH/vzOeAZm78JENG3rbMpFNdewySqREa6wTE6M0unDY75ERAIe4tsw?=
 =?iso-8859-2?Q?PFTXxvSblY1tBFXd0ER1rZWPbpg+5FHc1xkzX/i34i2EAdS+bD/mNeSlbn?=
 =?iso-8859-2?Q?QPszqqhOQ95TxPl/UHwnZ0+FhRURcwg3/XhP44FYN8ZFWSUf4gL/1p2eVt?=
 =?iso-8859-2?Q?vgtqh04g5SXScYtuFj0B1j5KWEwovPrL8kcsGHonJSs7vWvC3dXFP52n6G?=
 =?iso-8859-2?Q?UddCQU0LKLAOZcFfsvHnorH2ISn7MSYoHE3I//YoIQ7PMVGUk7MJigZttz?=
 =?iso-8859-2?Q?oQXIA96foFELi0WuCuU1K02MrcALZeZFc50eIKlngmqEIkVwOLYsI07ejK?=
 =?iso-8859-2?Q?uMTPB5z9rWMhc7g2ayO0BFEf1iV86kPSqyTW59Ctxzb98ghhetHDstTJlG?=
 =?iso-8859-2?Q?ug/hF5FjXwyMUiojCeCQJZM6vVBw9Dv+OjcqbXsPihM1Wu7uQAZHkvXPM6?=
 =?iso-8859-2?Q?uaf3IMGOsBvvwA7MY/4pjhaa6H9kPcDgvkfmBFrPVL9DTqSAFaF+lPxNT9?=
 =?iso-8859-2?Q?lNk6gTCORGLiG+BHAA36Eaj1Rjc494Ndu1fKHFT3EgICPBnGPJ/jlQlL7H?=
 =?iso-8859-2?Q?mV/UMcVei7oaE/7YOmgtRAJsj3F6wnFyW1jET/y9Wdq+ddAtfaEGCv5b9Q?=
 =?iso-8859-2?Q?I80+fwwpujC1B9s4ofxPaFiw9lMIomQ/tLPScK+4QQe8IU1wyyM89JK2dz?=
 =?iso-8859-2?Q?cVucN1DS5e4J0sfhO3dPxxGSUL3SaCzBzsI8U1kVNMmSlgq3RZzsh7xGTn?=
 =?iso-8859-2?Q?0fcBEXsooLXRfaI0cwFjPe6FMn4dxNk1UlVzOT3wYWxu4KXHIQiWfnc9nq?=
 =?iso-8859-2?Q?iFur0EKcXus1bVFfQbecYr7hw7yTITK0JCsJDW1L28dzllo/xzuwTsiOY+?=
 =?iso-8859-2?Q?tfqkELrZkfMF4R0TqLEzSlE/RjLcLVaSzpGFhgwRAd1E4UEcyU5PLO/MhS?=
 =?iso-8859-2?Q?y+Ss/LiqVVwGKi1U02obyQUQdjvMcyY8E03yhNwBhS1DmYabQEiVYHJW5q?=
 =?iso-8859-2?Q?WfIcm75RLsGmJkuYsFUpT9VWZETicHU/p1LakXU8UwJLTIRZB2yUuA0XOm?=
 =?iso-8859-2?Q?AxCIXrkPphXIP/u4bBISwLNTwu+jh+iMY9uj/+Yz6ZTT7EryH+q8VRJbhY?=
 =?iso-8859-2?Q?HWoRLjmdpGBbH0XAnMfUyEKu2CvX962HRt2+RPzpqmtYgVg/xOphwXSW46?=
 =?iso-8859-2?Q?Z6+hu4naKWnr8QXsoVopBVoE73G5FxXnRtlBXaPxqwaP2lrKZRTkmvAhus?=
 =?iso-8859-2?Q?+PvNuwiEJEsKUWpT?=
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW4PR21MB2002.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39e0218e-c9e7-4d21-d083-08d98a7fd800
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Oct 2021 17:19:53.8171
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fVQnLlYx7DXZB9UqloRYd5AXro1u7NcZlG8xB2Gfp1dfHYfs/+qj/LkPl5bxwMnYiWpbJVFmW0VDStOM2Yi8bQiQfhQKWk6XiTVVpZbObew=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB1851
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Current Hyper-V vPCI code only compiles and works for x64. There are
some hardcoded assumptions about the architectural IRQ chip and other
arch defines.

This patch series adds support for Hyper-V vPCI for ARM64 by first
breaking the current hard coded dependency in the vPCI code and
making it arch neutral. That is in the first patch. The second
patch introduces a Hyper-V vPCI MSI IRQ chip for allocating SPI
vectors.

changes in v2:
 - Moved the irqchip implementation to drivers/pci as suggested
   by Marc Zyngier
 - Addressed Multi-MSI handling issues identified by Marc Zyngier
 - Addressed lock/synchronization primitive as suggested by Marc
   Zyngier
 - Addressed other code feedback from Marc Zyngier

Sunil Muthuswamy (2):
  PCI: hv: Make the code arch neutral
  PCI: hv: Support for Hyper-V vPCI for ARM64

 MAINTAINERS                                 |   2 +
 arch/arm64/include/asm/hyperv-tlfs.h        |   9 +
 arch/x86/include/asm/hyperv-tlfs.h          |  33 +++
 arch/x86/include/asm/mshyperv.h             |   7 -
 drivers/pci/Kconfig                         |   2 +-
 drivers/pci/controller/Kconfig              |   2 +-
 drivers/pci/controller/Makefile             |   2 +-
 drivers/pci/controller/pci-hyperv-irqchip.c | 256 ++++++++++++++++++++
 drivers/pci/controller/pci-hyperv-irqchip.h |  21 ++
 drivers/pci/controller/pci-hyperv.c         |  58 +++--
 include/asm-generic/hyperv-tlfs.h           |  33 ---
 11 files changed, 363 insertions(+), 62 deletions(-)
 create mode 100644 drivers/pci/controller/pci-hyperv-irqchip.c
 create mode 100644 drivers/pci/controller/pci-hyperv-irqchip.h


base-commit: e4e737bb5c170df6135a127739a9e6148ee3da82
--=20
2.25.1
