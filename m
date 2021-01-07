Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 834292EE69F
	for <lists+linux-hyperv@lfdr.de>; Thu,  7 Jan 2021 21:18:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726073AbhAGURQ (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 7 Jan 2021 15:17:16 -0500
Received: from mail-dm6nam11on2095.outbound.protection.outlook.com ([40.107.223.95]:39168
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725944AbhAGURQ (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 7 Jan 2021 15:17:16 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ny8nHINNdw0tiEoroY6FRMIF5hvyuJRmBP6TCdqiKxWYex42k4RK/34+NCPUpyqCkfBzxOzD/h8nFG06KJa5y4pF2RlsBGfmYpyDeRiC/fTKUA64uI8zOoEkHNe40QoYrMAiypkcmBcadZlliah41ZPfvogNOnLPnuQGQZw5bbrDjlY6jKm6q2dueLLr/AW/PbjoaZlGGg20uIg1fFtNYrTrmZzuMKaAp0phVYpWFbziI7FTGUIR+Eq4rj8JBtwtrOcVd7PrB2JAHAkrNE1VPefMRNIMKPSm2Q4+t9W0H+ZPkCWahqNSkMHT5LscTDIKBbYYHeranvQfSS/ymwFWlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vEbT2ByAMgKTWwhpM5hA5ljO/KVz/3zRz89Lpj68sCM=;
 b=LmHyC2DqA4uyeX+6Oq7O6lXDWPN3TPYWuvkSXz8spM+TKuPvDx69FKgZLUnGVl0ddYlguzfvbABBTCmOoZNT64Y3rGfT4gAKrDCkUcJ6SMd/6aoB5WJ9v2sXeCzhqubwnK8w9L/bMDzl8Mh84iliGMF76Zo/HK/tbXJsuQaXZXNG98SggXTexr+DvM9boxnj1dau5uwCWiDovIbSiBYgSj/A8n7lnEAeowP5Sn4HZXWMzrESG/fy7XCvUfpPvcscaHiV2U5QVjFcgcB8p6c3bp9l+Q5G1xgjfOhmiru63MLrCCEoBw9iFl25gbWbHQ4ltsnM/Qf/LhPV4cpt17AZsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vEbT2ByAMgKTWwhpM5hA5ljO/KVz/3zRz89Lpj68sCM=;
 b=Esf2EvkH9kt9pIrTbavlw0T2u66VgRT3IfBu1NhFwtErW8dv7uyBpRIHnmKE1rTp1CDyzYsCquE5xKa8tnjQcYqsg1sw2tAMAgucNf0d6F4Nl8MMubJE9I7RFbfj4OdMwhCra21HJ66QC6pL755OE0Kt3a2on9N6eSej8wZUnmo=
Received: from (2603:10b6:803:51::33) by
 SA0PR21MB1915.namprd21.prod.outlook.com (2603:10b6:806:e3::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3763.0; Thu, 7 Jan 2021 20:16:28 +0000
Received: from SN4PR2101MB0880.namprd21.prod.outlook.com
 ([fe80::18ca:96d8:8030:e4e8]) by SN4PR2101MB0880.namprd21.prod.outlook.com
 ([fe80::18ca:96d8:8030:e4e8%4]) with mapi id 15.20.3763.002; Thu, 7 Jan 2021
 20:16:28 +0000
From:   Sunil Muthuswamy <sunilmut@microsoft.com>
To:     Borislav Petkov <bp@alien8.de>
CC:     KY Srinivasan <kys@microsoft.com>,
        Boqun Feng <Boqun.Feng@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <liuwe@microsoft.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        "\"H. Peter Anvin\"" <hpa@zytor.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: RE: [EXTERNAL] Re: [PATCH] Hyper-V: pci: x64: Generalize irq/msi
 set-up and handling
Thread-Topic: [EXTERNAL] Re: [PATCH] Hyper-V: pci: x64: Generalize irq/msi
 set-up and handling
Thread-Index: Adbksm0P1pe4NiY6T8iz9IYs5m9slAAGSEyAABmHE2A=
Date:   Thu, 7 Jan 2021 20:16:28 +0000
Message-ID: <SN4PR2101MB088009D87B77E37943B2F007C0AF9@SN4PR2101MB0880.namprd21.prod.outlook.com>
References: <SN4PR2101MB08808404302E2E1AB6A27DD6C0AF9@SN4PR2101MB0880.namprd21.prod.outlook.com>
 <20210107080317.GE14697@zn.tnic>
In-Reply-To: <20210107080317.GE14697@zn.tnic>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: alien8.de; dkim=none (message not signed)
 header.d=none;alien8.de; dmarc=none action=none header.from=microsoft.com;
x-originating-ip: [2601:602:9400:570:916:634a:e039:b890]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: dc01d6f4-38a4-4700-f9c9-08d8b3491d97
x-ms-traffictypediagnostic: SA0PR21MB1915:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SA0PR21MB1915FA2711345BBB815D2006C0AF9@SA0PR21MB1915.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: MftBwuAe3ZwnPxXdm4L9zTPfOempL0dvzJ9wTsUFAwnVyvlWfzNScq5BwoeoMU+t+QovbBL1vQyJSVqSTSxjccj2bFFcoxYOSz8uniG//X0h6aczPPpguj8hj+B116LxtqoJmHskgmG1zaY24HSM2lKzKAo8+zslC3u0NeC1nywklVMLIaAtoUA9SEDCzXbqdkpXQf1u2TxkaW0fmVupIyEJeuWUkTP7J8ZAACmSJtyun+49OR6z/6oUCts3dZmc+yLaZlLSDVzew5BgLVV4h1TWkImKqtSUt9UpGM5l9ECGS5Cpnj3GWtG2aOv+U1csHa+0fiSJ91rkwkXRp+Om+mw1iAa0o5bjvrSnAppndxVuoGbpn7xNOLymiYEVYJS8uy0i2DOpcHIrx15KGRGHsQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR2101MB0880.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(396003)(366004)(136003)(39860400002)(376002)(2906002)(10290500003)(33656002)(82950400001)(186003)(82960400001)(8676002)(66556008)(64756008)(66446008)(66476007)(86362001)(66946007)(52536014)(8990500004)(478600001)(6506007)(76116006)(8936002)(7416002)(71200400001)(6916009)(7696005)(4326008)(316002)(4744005)(54906003)(55016002)(5660300002)(9686003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?1r8mmWSkPDsrjK4oz9vmnTu07W+imbuFvla8pznqTSMAKq1eXfaB++rPf4u8?=
 =?us-ascii?Q?t8+IqoGN+wH222xxAhtPkNw7xcBf0WnPR5h1IFsRwI7ZUlZJRCvUu65pD1rB?=
 =?us-ascii?Q?rtxMGYUBFCGROTCIMMAnIr79BiA/aCNiBxne1+Dg69FWCdL69fgUeLOfX7/g?=
 =?us-ascii?Q?RPRN9YIWxmHrNpv3ygZpLfMvEjIeo59g/lRxki4bAnAGTQJR8X0pNmW190ZC?=
 =?us-ascii?Q?qh5kZjFqdSBm+Lxs6+69Yq7eUUFNP2FEFSmltDrcvGD+h4ffCcck7yGsPk1B?=
 =?us-ascii?Q?ULkpieDt6wnjcSXUAM2uuWa7dWpXADS6QHJosg7JxtOFW1zI8VP2DFo0OoEh?=
 =?us-ascii?Q?v2v3HjWr0ZZ92HAPMXUTGqf4/x7FyTxM+QLIrbxmt/BPmLmT/T+kpuqGykUW?=
 =?us-ascii?Q?QcbY3Y/P0XBA65aQA/9eUg1sHXaGwOgaBu8PAG20ps9OWjFOtSPq3iTNxFnF?=
 =?us-ascii?Q?CLdwk0UjB6P/kc/UauC2h01HzlDbEqrzAcHuzUSDEc/anr7ndTLVsocFUJLk?=
 =?us-ascii?Q?lLElav42VhIqlFPWrC9JwgEVm8nDaCv0RuHPf4KG9sgQ+blcG40CmxPOE8/y?=
 =?us-ascii?Q?xhXoyjz/AzUTLHquVqxWv/7NyfBhIGPjEAjJwlynnASoeGXHi49nDyrCMa4t?=
 =?us-ascii?Q?kgavdc+8t3bdjXWA+PW8tG778lzWf37GTmvrZjIRWELDa9iZj9dfyyfGFAtO?=
 =?us-ascii?Q?8N9NkSIe+3EPVx7jSlgjB6lqq9TIEId4sE0FkVKC0cO5iUVW6C0SiP6l+MYu?=
 =?us-ascii?Q?zgEWtxY4JkIwd3yUrS/uNYrOpJYJueavrm0jnyc3SNEATyelsCA4mGmgsYN0?=
 =?us-ascii?Q?v3X+xSIrXk0a1pYaZhTMoEghFTYHnRUKkyjJOx/1QGFD26DV5yUtT1K/Fb2a?=
 =?us-ascii?Q?mqev41Skibxf6ANQmnHjw7U/7nktpiLxbFdkkxZaKqcsfTXMzhd09DTCDZFf?=
 =?us-ascii?Q?rjWuGOpuWoEfF17NEP12m03z7Y1IXrzCWa/lzonrWETgJS9G2tZLryqq7WtR?=
 =?us-ascii?Q?UQ0Oybf7ZZD70274Lx73qvzw+BNtfhxum4ypsCB7IMQNfks=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR2101MB0880.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc01d6f4-38a4-4700-f9c9-08d8b3491d97
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jan 2021 20:16:28.2021
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6KEJ2LFpkRju+JzOMw3dTiuF359HPczrRLQJajqWMzf0qQSFwjybZYx35Y8YnqHyshcZmOR9fvVIqyz4fr4wIbSTzsMsAscib5CT7SzM9w8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR21MB1915
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

> What is this SoB chain supposed to say?

Quoting from the link you shared:
"The Signed-off-by: tag indicates that the signer was involved in the devel=
opment of
the patch, or that he/she was in the patch's delivery path."

My intent to include Boqun in the Signed-off by tag was to indicate that he=
 was involved
in the development of the patch here.

- Sunil
