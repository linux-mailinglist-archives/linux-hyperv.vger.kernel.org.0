Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A2792EE6D3
	for <lists+linux-hyperv@lfdr.de>; Thu,  7 Jan 2021 21:28:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726908AbhAGU1K (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 7 Jan 2021 15:27:10 -0500
Received: from mail-bn7nam10on2131.outbound.protection.outlook.com ([40.107.92.131]:38497
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726878AbhAGU1J (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 7 Jan 2021 15:27:09 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OzwKpZKsJ5sFohTTMb3cK3iqXWZkBk0ZxtCGPQBTCraMc1/3UXDeSwb45BYbEMu/BJl5rWrtsUEGVDikLFVHrkFF9p4M34BQSm50rVdgvCIdZrRPXlFKqOFaDfZa8ncotHN/PgiOft3GbP3M93XFm0k934epZ9Xm6dfApi/iOQMbkGeNkc85/NJXBFxG9qNop8DNH6wLfo+2VcO70zqBvx2U+zQrDzXWxYwC1Zxez1zKDFmIIIGvn1Xh9VAH4MX+/RRZnHUhiMjqYE6lh5X/uDU5q7GuyaUC8ezAZgr1K/zi1/cpPtUpIRv0kDZT7DsoWUsMXt9Tdhb4tQKWV2ttJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qrgW82o94Tvx/iFBKibYHVcE1jkXeC1y/KlotKMNoEk=;
 b=SCHtLoiphMIjjFY+CH1lT7LW7FMyz321qZvbezKwpZlQXR19TLzPlYB+m7Y/kmMwnd/haRftE7q52XiTLG51DecY6P6Q9AMTp16/DxN2XO2c5Mzc/K4tZ+jwn8emU27T6Ggaefigtuu+E22efKa+W4P9yPowQHT2GE/vBixqx73mdLbsRhF/P5ek1+SXB93/4Tai8eBnWDDpllJT67AJDmrLQOCtjyp+/NPxHvD2ODbL6yU/oXJXBBzvPVGfZFjMyr2yH2eLh9l3bY994jZwy6fiDi4ppqGT2oPJPjN9u9lFsvqs2iTVEVUR+q8QL2hCdglEZpTiVaBFDSwmu98bdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qrgW82o94Tvx/iFBKibYHVcE1jkXeC1y/KlotKMNoEk=;
 b=dNaRxCpFjW3rmPCC/a0B3ympPb8TCA6/Z4KtVoh6aeNTUDaRc6XzacgS6wiF6ixSZtLf4Cfh1pN4NHSjgpZcmXU5rubObriOSz6vzGh319U+2epFd1qJCyfTOltKLOQDcS5UCXvLPXqHbHHKiGEMsxS22Jwn9YJYDLzu1YZbjYM=
Received: from (2603:10b6:803:51::33) by
 SN6PR2101MB1775.namprd21.prod.outlook.com (2603:10b6:805:12::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.0; Thu, 7 Jan
 2021 20:26:21 +0000
Received: from SN4PR2101MB0880.namprd21.prod.outlook.com
 ([fe80::18ca:96d8:8030:e4e8]) by SN4PR2101MB0880.namprd21.prod.outlook.com
 ([fe80::18ca:96d8:8030:e4e8%4]) with mapi id 15.20.3763.002; Thu, 7 Jan 2021
 20:26:21 +0000
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
Thread-Index: Adbksm0P1pe4NiY6T8iz9IYs5m9slAAGSEyAABmHE2AAAD+bAAAAH6uA
Date:   Thu, 7 Jan 2021 20:26:21 +0000
Message-ID: <SN4PR2101MB0880D472496D462EF54E71A1C0AF9@SN4PR2101MB0880.namprd21.prod.outlook.com>
References: <SN4PR2101MB08808404302E2E1AB6A27DD6C0AF9@SN4PR2101MB0880.namprd21.prod.outlook.com>
 <20210107080317.GE14697@zn.tnic>
 <SN4PR2101MB088009D87B77E37943B2F007C0AF9@SN4PR2101MB0880.namprd21.prod.outlook.com>
 <20210107202120.GJ14697@zn.tnic>
In-Reply-To: <20210107202120.GJ14697@zn.tnic>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: alien8.de; dkim=none (message not signed)
 header.d=none;alien8.de; dmarc=none action=none header.from=microsoft.com;
x-originating-ip: [2601:602:9400:570:916:634a:e039:b890]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 121ab514-7729-48bf-afd5-08d8b34a7ef5
x-ms-traffictypediagnostic: SN6PR2101MB1775:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR2101MB1775E2EF3F0EE410A650A429C0AF9@SN6PR2101MB1775.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2887;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QQCKtOzlGIyvrUoOJXX9A9g0XoLjgJv39EOX1A13NnyNlHD1xq3auQhrWkWJwJcEaW6NYwEfRemihFAdVkQCVtmy9N83UCS19l8MbUoGwPI+nad2zZZd8VjZdnzOCBpfyaFsJ3dCuQsSBF8UcScXZOyRk+/+n5xIQPhsHi39ldR7D3V1UFTyplIhRS/BCH4COq3nP+rYEoJFgKXQLVDrUj+CLZXyDdskWv4De1jGakBubzzhk+sJaXtyK12cNXesZTs2XTKyrVpcZcCuSGnEvDQVvKJ2sQfT5YYwxfYElZfIQn/3g6DdPKPNry9pJG2d3QBlYV2NQ+p73zbWYUUFxOOGCDT0LGejjapAH4glfUevXZIuAfBLwh/gTMQHea3jzOUsUYeGGKrGKZmPgrYq7A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR2101MB0880.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(366004)(39860400002)(346002)(136003)(376002)(7416002)(76116006)(64756008)(9686003)(66946007)(66446008)(66556008)(66476007)(8676002)(8936002)(55016002)(71200400001)(33656002)(10290500003)(8990500004)(4326008)(52536014)(186003)(7696005)(6916009)(83380400001)(5660300002)(2906002)(6506007)(4744005)(86362001)(54906003)(478600001)(82950400001)(82960400001)(316002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?idFzZD0BW+06MZm/3JCv7lCVk/dc/4Njzo3/fCaWDZbkmobf5o6mIRdwVK4x?=
 =?us-ascii?Q?v/jCAWA6Oi6qaiKBmD6p4d7VlSedwqn+/3H6IG1VZxFSuf2AVQ/b0TsNHMFi?=
 =?us-ascii?Q?y9pYymhvEICmW4QKGr5bCqDZcsD1DGehU298J3lOQ7vL68eS7fuIzX21qXZ1?=
 =?us-ascii?Q?hbUIoDz2W5906t4FuMg9yTDde0mriUrHPFGY6vJ+LxDdOvSPLwE6dRaPPPyl?=
 =?us-ascii?Q?vdisLrm3WLwe0/5+0e5pf+A1Nb5D9XbNUwXVQUTUn4km9UCEZM1iTl7rEHNp?=
 =?us-ascii?Q?iUVOOh5giGZ8pH3GbzyCJ+idA8rQCeB/Nzj6L/Ab9Q2GxVVJV4WcaBMk87pA?=
 =?us-ascii?Q?kYlpRx1Ada7okU4FYdl72DwTmnC2QV7bHJdDJhHxTtgij+F1ArdovwxPlKwj?=
 =?us-ascii?Q?swkzMmjxasSD48I4LhrEtrubEyqkL5W7t9TgGpzRijFXoOQ1+8SRqXkGxnoU?=
 =?us-ascii?Q?zz5P/xYRQ8lAXt8VywYytjcMTEGXaBKo/4OfpxLl+H0mqy3BF+p3cPyqlQ+3?=
 =?us-ascii?Q?IwEtJQKPwhFawvT23dXRkav7qoHa9OoggzmVLmSsJhSS27DiAT9qRThIKDWz?=
 =?us-ascii?Q?iBE/nQ/hCHcWngvunq3bhIJCe3rDXtNdV2lp1zaza4q/UvXDnqiurLXfS9BA?=
 =?us-ascii?Q?ArItDnAKFDXXm13RL+FySCJXhCxaIEeWmi3Pi24dlesouezvBxjakizX/sxi?=
 =?us-ascii?Q?0zP45oehG6CpjfkRvAsMSQWm4SiiyX1DOM+Hz02fiuHTyFm/gZ8TyjLpSJLj?=
 =?us-ascii?Q?H+ImV3TTQgCxu5skP5P6L07V9/oW83+pCiuQ45gE1Q2qClB79OVdMbZtdAMH?=
 =?us-ascii?Q?zkjCg3inWuQxZ5uau9irfsWNcaW+4Qeq/WIk9LcZxFUWdF35WyyIufk9iC7+?=
 =?us-ascii?Q?yxWbe2cWgXdjQNehi0veb/HZcUwDl9oXT/a7hA+YW83OmC3OMORdDOJu4zjx?=
 =?us-ascii?Q?ts6nO2x/oGd95J/SIM04O4Bk/0nn/6v8F649+bIGkqvWx0leJzPMrghbSMzj?=
 =?us-ascii?Q?qLhQsp2jFAD/a4gO2VuXAWb8Pnv3hFgn1dG9ZIlZVC8Yv+A=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR2101MB0880.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 121ab514-7729-48bf-afd5-08d8b34a7ef5
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jan 2021 20:26:21.0335
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1OPND/vXkZlbCXd7LfdqDPzVB/crhEmgll3vjyN4yCS+mQAsnWKx7CrlUyPUoIpFkJ9Rkqz3N0f3tZyTWLS3lrL4Tph1vWVs4tguEG1vBfo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR2101MB1775
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

> Do you see "Co-developed-by" in the title of that section? This is how
> you express co-authorship.
Yes, I do now.

>=20
> As it is now:
>=20
> Signed-off-by: Sunil Muthuswamy <sunilmut@microsoft.com>
> Signed-off-by: Boqun Feng (Microsoft) <boqun.feng@gmail.com>
>=20
> it says that you authored the patch and Boqun handled it further, i.e.,
> he's in the patch's delivery path. But he isn't - you're sending it.

thanks, I will send out a new patch with this updated.
