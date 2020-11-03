Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABFA72A4071
	for <lists+linux-hyperv@lfdr.de>; Tue,  3 Nov 2020 10:37:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726109AbgKCJhK (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 3 Nov 2020 04:37:10 -0500
Received: from mail-dm6nam11on2132.outbound.protection.outlook.com ([40.107.223.132]:6807
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725993AbgKCJhJ (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 3 Nov 2020 04:37:09 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JYpHEjOTmRqCnjNMoeu9/usOCDiVKro69HBSzvU8e2TwbF6aMD9kJAEUhxd9CC6d6ypzk1ECkrs8yvUiP4n33b+DVNtZYhRtQ7+bslLKzOIRa+DQzzGKJ8kCCW8d0fM29lCYO/tbcQ8XPB9/LrhmPSy7meDwEo8kgCly7RXSVspoEAZduN5IDT57+wYHi+8+dKOxd28IUpy+dAuR/qBuZz/Dqu/deQJkepJXk5GUDS5foqgVeCCDZ1JB5PQYK6OKacneOG3ap/sz+Zc61lrAg0znaZSATy66d2LWZQneMH8+vqixkzSbyDk5j+xdermN3iia4UZbkioqSPxY/ErxJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+dwBmazPdnGl8a6uBm2YSer73HMKYpXXIcusPW7s8M4=;
 b=QOg6MUldtckwSw9LIQvBoNSuMr3f1FBU4SZGCnhSzZVMBdmdP5kRrJl5fPGrg1wjoPQUxTywGqEig6gMkoKaJmjxXFqaQ4DZx+7ACQEtdHrrZM6hmtMQl99lMx2JNwIu92UYDPf60rvVoPvPq/kUXl07AOzIN0oAzgJcpCcHi3B2UXBUZH2FD3/jGEKe38VUbF/Nym29d2EMSTF68ASRGtciRY2mQ4+PoeY20yrIj89Mziwj7YHLJuN8z9m/uLeHyqzStZPt3mAVr73tI4BpG46ZmY2I8Gne7e7PjW58+IBVtUDrrBpQY8N6AbAzc6g0ID/EWZ0EEFSU4C5QJNLbDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+dwBmazPdnGl8a6uBm2YSer73HMKYpXXIcusPW7s8M4=;
 b=JmWlhtu1J8rZY+NoAqeeCk0AFXi5qid+laJdELxTkZG4RrCiuVD69Sm4psRibToaXXHz4OQv4PCivwX/RyypCK+ZIXDmnIY7EXuLvhVHl0tdWSVenmHEL2aYK72yryebukWl6kah8BrUMHZN3bmCuIb6VYqtEps8StqU17Y6jGk=
Received: from MWHPR21MB1546.namprd21.prod.outlook.com (2603:10b6:301:7c::21)
 by MW2PR2101MB1020.namprd21.prod.outlook.com (2603:10b6:302:9::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3564.6; Tue, 3 Nov
 2020 09:37:06 +0000
Received: from MWHPR21MB1546.namprd21.prod.outlook.com
 ([fe80::a4a4:2fa7:b52a:7f1d]) by MWHPR21MB1546.namprd21.prod.outlook.com
 ([fe80::a4a4:2fa7:b52a:7f1d%8]) with mapi id 15.20.3499.030; Tue, 3 Nov 2020
 09:37:06 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     "tglx@linutronix.de" <tglx@linutronix.de>,
        "dwmw2@infradead.org" <dwmw2@infradead.org>,
        "x86@kernel.org" <x86@kernel.org>,
        Michael Kelley <mikelley@microsoft.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Tianyu Lan <Tianyu.Lan@microsoft.com>,
        vkuznets <vkuznets@redhat.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>, "hpa@zytor.com" <hpa@zytor.com>
Subject: RE: [PATCH] x86/hyperv: Enable 15-bit APIC ID if the hypervisor
 supports it
Thread-Topic: [PATCH] x86/hyperv: Enable 15-bit APIC ID if the hypervisor
 supports it
Thread-Index: AQHWsX5b4+ft06KSG0GlKPe1Plvd8Km2JGLQ
Date:   Tue, 3 Nov 2020 09:37:06 +0000
Message-ID: <MWHPR21MB154620E39FDDF862E8906249BF110@MWHPR21MB1546.namprd21.prod.outlook.com>
References: <20201103011136.59108-1-decui@microsoft.com>
In-Reply-To: <20201103011136.59108-1-decui@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=25dc956c-a592-4bb2-b1b3-a14cfc50421f;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2020-11-03T09:28:28Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: linutronix.de; dkim=none (message not signed)
 header.d=none;linutronix.de; dmarc=none action=none
 header.from=microsoft.com;
x-originating-ip: [2601:600:a280:7f70:881e:8402:7b3a:208e]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: bbbe004a-31c0-4d24-7821-08d87fdc0747
x-ms-traffictypediagnostic: MW2PR2101MB1020:
x-ms-exchange-transport-forked: True
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <MW2PR2101MB10200417DFE86D1A7ED1F7A0BF110@MW2PR2101MB1020.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2887;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: SZBSdfPEIal1qE8xh4mXSvYHrx1zn3jKbGfqLmAVfqPiIy+d/YIjio7hMnwwDAXKxx9Y94c0SoLyzD+5nfMJzL+W9Vmj7cSzLL3Lv7JAh43ebI0boGhsa6JosKS1vx5j/zonup4JbWbtsQ4JUDqkmxwVAydSgP57AIbcwBPd2qYx7ZOE2T4irL0Y+jOTh+HJzxlSI2XY3F4G4NUoiT0yJbkhw6xQ0PYA3EbV8ayG2558GgcrArdnhVWFYSo4PgWAM1SWFGS0s3D/YeNWXUGyTlHDDWGILAJ0xqnlZWesec8iRFj5/rEY64Y/QszvdQKGJR/teeoPbHISQEiasCDu5Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR21MB1546.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(366004)(136003)(39860400002)(376002)(346002)(52536014)(55016002)(9686003)(8676002)(71200400001)(4744005)(2906002)(186003)(316002)(33656002)(54906003)(5660300002)(86362001)(7416002)(82960400001)(4326008)(82950400001)(110136005)(76116006)(10290500003)(8990500004)(66556008)(64756008)(66476007)(66946007)(6506007)(478600001)(8936002)(66446008)(7696005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: P+LhaX4mx9YpzjfTjrW7NCgaYjnHPxoPplxIZyLcsl6iA+CxR6VZIC5/PXlZ3UtZGNqOikaNFBwmawMTgK6y/uDqnIsayj35cBDgC6z4KDSVT/5mECNqC5jTZf/RuqmsMgGcW75+Bt0KEgxcLcqgfReEnYrMlKdZPz+QzgUbS46AzLWUUFqiDDklJkrUQX67BTuoGytUOsUB4VIKboHaYc4Cn3Pjhcjp4ibfYnsOFKYnsE1SwYgg+51TOKt7ETQ+cdhp6HlpLrH1s3SlklpfYqN/f5h2JrnnncRc5QYzpUU7zhLt0EoLInByQ89PoCOt5SkqyWHLzAGxm3+welDEE7E/a8asu+7qAYDOodEL7EyA4IvkGIEc2d3Tk1zn+TD7eNaGKgG0slLnoDWDOALcrT0NkimmUwRnqp/1/01xBKcMKbaoeaBKdga5Ko0dM9xlErQyF2n6AJCEouYqz21WvL2jgF+40vQtfJiBoGljuxMp/23CIDZoFRsq/XC5RePAkaLXx8DlgtreDOKemHasPvmF+p8Q3gZZ2Dt+2Ba5Y5p9N0/I/Hq16wAhxKeZgler43D4iM8j3KO2BB/eklmWSinY0PQ5TayxRQ4mZItQKm5p88BdfqITjqSRDWz1SsvqPxKP7UL6HZt7TJZaClxt+JXTlCQs8FRIr8ohagQokhknOdRXqDmeQJz4NEplyagODZHAGgFHqg9QCjr6Vspmag==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR21MB1546.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bbbe004a-31c0-4d24-7821-08d87fdc0747
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Nov 2020 09:37:06.2363
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1r8Beih+IjNy3kyOKgLnOlsMr2KjyB90G0CVA6lm2zqhOXQ+kU/RxT4dzesLIPTxobUJiGUBpdF3hDTcdemEyg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB1020
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

> From: Dexuan Cui <decui@microsoft.com>
> Sent: Monday, November 2, 2020 5:12 PM
>=20
> ...

Hi tglx,
Now this patch is in the x86/apic branch, which is great! Thanks for the=20
quick action! But the third line of the below paragraph of the commit log
is missing... Sorry I just realized I should have not prefixed that line wi=
th the
">255 APIC IDs" -- it looks a line is ignored if it starts with 2 chars of =
">>". :-(

> On an old Hyper-V host that doesn't support the Extended Dest ID, nothing
> changes with this commit: Linux VM is still able to bring up the CPUs wit=
h
> >255 APIC IDs with the help of hyperv-iommu.c, but IOAPIC interrupts stil=
l
> can not go to such CPUs, and the kdump kernel still can not work properly
> on such CPUs.
