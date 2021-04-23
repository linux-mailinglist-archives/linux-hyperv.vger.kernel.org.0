Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA8333699E7
	for <lists+linux-hyperv@lfdr.de>; Fri, 23 Apr 2021 20:41:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232211AbhDWSmM (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 23 Apr 2021 14:42:12 -0400
Received: from mail-mw2nam12on2104.outbound.protection.outlook.com ([40.107.244.104]:61696
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231684AbhDWSmL (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 23 Apr 2021 14:42:11 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ds46aVg27G1fqG80JKNApfNcQH1GDrj+waAkZC9sbfIjp1CPXPPkX19leQV+/8boyMnt4ARQSvWLI57XWgHpNVUuYEZeNcNzu6nDubT8bpGddiMqaCaxDs9f9TQFl0eCpOBYJv9LIjenLo9qajzQ55o7cVqYFRhnbagb2gh4EAZSl6zkDuDNKbPb3dxntl8xdCDYPPbaBnyKHj1Lqf2SaU+Z3Ujn6bsaY3lV3NNCgGPqLtx8YuebcF/6WezxlQShaXXYo5bGPyeKytAQahW+r9nFDD258gRhHdl/93J/hsAseBTAna4nBE9AP8d9scR7CGIU+w/alW6Ttc4rfQgj4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=viY3VigOWx2RFE5ZEx8juSy95Qx4CbqF0XqG7NLfIVc=;
 b=Kn5kfEHHcne/OhHfaaugVfTE671qbziO6fhPI8tl4JjQPLwT1jpxndYhXnXEF9kqosC8EkXkfYnVxxsP8Sj8sor0I0vSARrJ6p1BPxV/dMp4w7zK6vbwwP55uioboRIlOAJvDIwMDF2jjFGY9sRw2qKzud2K61G4COBTfVC2gz4Gcr3rXu396ra2dVMm/Nq2lyVNNNjiKfgLbfkcpEBtRLj752nxtuqU3NICkZABeg47MQdteYABGbMJw2zV+sfdYjPijISg7w7WHEBVjlh8gdIsnFVSxQ+MLXzjSVwJP8e7riPr4x5fB1/WvyXEDWO2pAEA8wOxAXA8ws0Pe4/sIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=viY3VigOWx2RFE5ZEx8juSy95Qx4CbqF0XqG7NLfIVc=;
 b=gYKsaJ7+xZTRHprYwy3WSo7UhTqt7SKVz12cFHQPLtleOYk1eJC/UzPOyDdHM8PD9XBsKujTlEWlJy6vDfeQDW4N2VtM0NLZuFx9n2iNm45AQxTBaFw0S/qCZq2F98mPRP27XlE29PWJRJOOk3N5l4DkjVN1uGgxLT2tYSa1XRk=
Received: from MW2PR2101MB0892.namprd21.prod.outlook.com
 (2603:10b6:302:10::24) by MWHPR2101MB0809.namprd21.prod.outlook.com
 (2603:10b6:301:76::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.4; Fri, 23 Apr
 2021 18:41:32 +0000
Received: from MW2PR2101MB0892.namprd21.prod.outlook.com
 ([fe80::5548:cbd8:43cd:aa3d]) by MW2PR2101MB0892.namprd21.prod.outlook.com
 ([fe80::5548:cbd8:43cd:aa3d%6]) with mapi id 15.20.4065.008; Fri, 23 Apr 2021
 18:41:32 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     Long Li <longli@microsoft.com>,
        "longli@linuxonhyperv.com" <longli@linuxonhyperv.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [Patch v2 1/2] PCI: hv: Fix a race condition when removing the
 device
Thread-Topic: [Patch v2 1/2] PCI: hv: Fix a race condition when removing the
 device
Thread-Index: AQHXNzrEqHm1W7VddEiGdCJpDqqWbKrBrccwgADBxQCAAAH5cA==
Date:   Fri, 23 Apr 2021 18:41:32 +0000
Message-ID: <MW2PR2101MB0892D7E83CC44D97F4317871BF459@MW2PR2101MB0892.namprd21.prod.outlook.com>
References: <1619070346-21557-1-git-send-email-longli@linuxonhyperv.com>
 <MW2PR2101MB0892A9A0972199A2FF6D68B0BF459@MW2PR2101MB0892.namprd21.prod.outlook.com>
 <BYAPR21MB1271F9B76FAA423D7BE6DDEECE459@BYAPR21MB1271.namprd21.prod.outlook.com>
In-Reply-To: <BYAPR21MB1271F9B76FAA423D7BE6DDEECE459@BYAPR21MB1271.namprd21.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=825368ff-303b-448a-ba43-6f3872c68267;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2021-04-23T06:58:52Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: microsoft.com; dkim=none (message not signed)
 header.d=none;microsoft.com; dmarc=none action=none
 header.from=microsoft.com;
x-originating-ip: [2601:600:8b00:6b90:55f8:4d3d:9b51:7264]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d2c5a49f-cf4d-4370-e446-08d906876a74
x-ms-traffictypediagnostic: MWHPR2101MB0809:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR2101MB080907708B0DD33D8D5F2E0CBF459@MWHPR2101MB0809.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xRiEHvygmErbK0EmnWmk53gou4vEsi064Lby57vN1gg6LnTcolZQlYvy4G+IW7euGOBi96juAapVVv+7lI9UKuW35hkUuJjj2Ee2r052Vfj4xchn3t0hA/YrfoWxi2O1hyaMFHdf2rAKefqIKtBrCxcYWle2mgkp9BGrUYqRuD6n/hsU0zule5ujrlsLUbK7QAUZi0YnVt/FYREaOfaenquaKf5lwf2GXIk0XFK+7pWYN1Qz1nMcl07zQTrInA4irzPNs/uXEFNZswDFBr4ZrrQhOkQlFU0cPBzmKWUTY3oyW8Nkuw8Cl978iERa9irGn4QLbMirjmx6VmRCsq+Dizi5PgsXK33xqZJQwWSzdrPxqzOwKsN4SUq3xRKn6lLalpHi9E6gPNHNDhDu0lpADZw1HyA/IeFQKOtwMhDuBYRoyV5+zQStoKQF/AK+6j9ewSjOXDrqHAIFHPtGg3/ulaFRTpw3TUIcr0T9oc/eRRWnBg+RsVu6SIyPOihV1ToGNqyhsxY3tt6igp+w4m2iAQYESpZDqp6us9A8iTpdL00hKFpj7dRHvTpxb8PwC7nosES7fIAVwVJIKt9KhrSCGpY4aCJcMGbnEOpDG6BTbN/5EgoyLQlX88iRlW1nFvuwTsE8eZ1LUed8I7CM9t4cxA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR2101MB0892.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(66946007)(82950400001)(921005)(8936002)(66446008)(8676002)(64756008)(110136005)(2906002)(66476007)(76116006)(5660300002)(7696005)(66556008)(86362001)(52536014)(83380400001)(38100700002)(6506007)(186003)(71200400001)(33656002)(55016002)(10290500003)(9686003)(82960400001)(316002)(8990500004)(4744005)(122000001)(478600001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?f/EBjZgz5xAz1+xAghAIQqTewsnEsh2RvEJ4uGBB2kFIqAdpmfyZSsim+j7x?=
 =?us-ascii?Q?sjhT7OeHGfqJn3oGCZkh3WHZZbOvSvDV9jdjtxpmOWuGmm8ZF7mkLMnWVvXA?=
 =?us-ascii?Q?89U32ooVrO9t650akl0vp40HtRDxKp8iEwAn00FJ8Hf1x9G74glo6wxHBV/7?=
 =?us-ascii?Q?REyBcWb3CCkxACZWl1FqU6QG/VuEwX6/vwXOBUsU9s2fNp45eeig0ij97PPG?=
 =?us-ascii?Q?hLCVVLyxrMHE3zdGHg8dn8RkyD+CnlZRTF9/Asi73gmWV2XAi/cI7sCCgFc4?=
 =?us-ascii?Q?gvkbSfOnMQv0mMN3wejbRZ4n0sVvk8HYYfHkOeDnxANQBKtjtf6x2wAhrrHC?=
 =?us-ascii?Q?fFYOJKaX0omxUUSZRcGhn3sQc0ts9x+oZ7/DFYe8on9adka1vws4RDhSztQh?=
 =?us-ascii?Q?5skK9ymD2Jgfh85Wy3N2y+GR4QlUsOKgQ7lLyjZepZSzlbYPhkSUBOzpKhQ4?=
 =?us-ascii?Q?nSidaoDYAl4uZ3/KJ4EvxUmLY8gPnqo8qDEw6xX8aBpFLWXDWID1IKuGJw/o?=
 =?us-ascii?Q?7WzOAcpiPbPNPLYI8Tar+8s0ZhOfb73afHLWQDr4ZT9TabvIsXUrH3pwxZdP?=
 =?us-ascii?Q?k89g/sCJ0nvdHvC0sboUCpy9W2lgly6McwQhjknWhBxDwk1lDe5jWBksBnWJ?=
 =?us-ascii?Q?TM1jzvBgCoWhimKJMyluxRkmkHBSEGZk1hlS8nErlvWZE86VKw9gP7Izo1CB?=
 =?us-ascii?Q?pd4qjJqFXv3uQfvD+n93rsAjUdVli79dBvupS/cnvKUfV+P0ofr4YSo/l5J4?=
 =?us-ascii?Q?/k7C9WeYsbwl2SUEYHyTbh7i89zA3/nJO8hoiduy6uazKsVJBlHoihhz6QbH?=
 =?us-ascii?Q?G67pXnUmCsQthg5jpxmbPqd9SwVrLT/N3CxBXRsHldJs0qBRcnoSKf0D3rkb?=
 =?us-ascii?Q?ZQlCZeGrjmEcQpj2I3RZvcpLya5MYrz/Tba3U0cvuw4cG+PUa6GLE1Kj06ht?=
 =?us-ascii?Q?w+C9aZA97pieEEGcPnfA5yto/roMuscEAW0sgZ0RxMGQ2Xub+Go7f0ALZnvF?=
 =?us-ascii?Q?XJEuYIgLZgfyAdC2GvzD7a9SZGBkaYKsH+DlnB8n3jR8Ig+B/jCL6BM5bP7C?=
 =?us-ascii?Q?jyPMS3Fg0mXpZgR7Nj/4PSulnyBjygVrPbgaKT7R6Vd+XDnvpTccNGn/Etqr?=
 =?us-ascii?Q?Sb7Q6q6Kj+MyW0XqE4WJDHgry9KzWNB1oUTTkNQrbYfjCkvDNNSN8LbrbaUt?=
 =?us-ascii?Q?+Gd2JMlyLxrwhAkGr7gWHDe5HwrqqYE/hKRBL+TPOZm2HkXfS/Z0Ya5PNtR5?=
 =?us-ascii?Q?EKDoulwnWV16mQCV8ltN6vxMSbhn5bOkHJt6QyX0AKge/py/LNdrsVr21o3f?=
 =?us-ascii?Q?i5HUgFjA/6LvF4Dnrppm7yfm6NRDy9f8DA6gKo2tCf+E0AmkDo8RfPJJkL9x?=
 =?us-ascii?Q?zSgDTRQZuVGeWF0dGNKjpR2GEY2j?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR2101MB0892.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d2c5a49f-cf4d-4370-e446-08d906876a74
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Apr 2021 18:41:32.4783
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eNhzXhz8kRBJyUqHI9r6z945oobe6nfyXtzbeO5C+ctIsY0/5IhFqvtw3cknBkCWSk5C1kHMYi6aQGSYRgnYzA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR2101MB0809
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

> From: Long Li <longli@microsoft.com>
> Sent: Friday, April 23, 2021 11:32 AM
> > ...
> > If we test "rmmod pci-hyperv", I suspect the warning will be printed:
> > hv_pci_remove() -> hv_pci_bus_exit() -> hv_pci_start_relations_work():
>=20
> In most case, it will not print anything.

If I read the code correctly, I think the warning is printed _every time_ w=
e
unload pci-hyperv.

> It will print something if there is a PCI_BUS_RELATION work pending at th=
e time
> of remove. The same goes to PCI_EJECT. In those cases, the message is val=
uable
> to troubleshooting.
