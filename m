Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 18CCE3211C
	for <lists+linux-hyperv@lfdr.de>; Sun,  2 Jun 2019 01:00:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726414AbfFAW77 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Sat, 1 Jun 2019 18:59:59 -0400
Received: from mail-eopbgr820094.outbound.protection.outlook.com ([40.107.82.94]:41568
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726149AbfFAW77 (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Sat, 1 Jun 2019 18:59:59 -0400
ARC-Seal: i=1; a=rsa-sha256; s=testarcselector01; d=microsoft.com; cv=none;
 b=fSb6VxGImQRbmaTavkMeZHoUsSVBf1DXWtzP/HAgRvmWBW14ual5jgSPk9qMxRD5bHZjI3ApOHBwsnc5pcE46fdq4e3YORh1MfZ3RMdq9F86ngck98feab2GpO4NL44j64Mj0NiXTw1WGEnSf5WVe20K3nnDWhpvF4OnU3t7epA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=testarcselector01;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6n8cSrZdPBP+APjT0/IEZ2BwuACDxsAQURtUZpdtFGg=;
 b=LmtRpazrLyzJLd1oQEqthEibTQtsCFdFtMI2EukQYlrugMU0LM6u0qzruVJ1cxpvwBhdZ/l/3qbOyrfzL+qfFmtulut7sfsfZQ2UE8CcjJXd6a40oFprCIfgc8FU9+MDjvBHa3kRWkrgUNWzxzlgPjSVcoKd8X/uszYZykY/b40=
ARC-Authentication-Results: i=1; test.office365.com
 1;spf=none;dmarc=none;dkim=none;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6n8cSrZdPBP+APjT0/IEZ2BwuACDxsAQURtUZpdtFGg=;
 b=P5a+za9LL/HR4pI5A4E15ovJHrU0eC5i7p9VKaaoOo92tqJMOyyru9eg1xrAr0AHHEMF6nOYDBqzNvAL5/i5cyRgvK8EgLm9SDV2q05hukyiMDi8yCJ6HTehGrNcWn9j+QOE7NMAlLsiB41UaaMNRu+CYrmnOhczmApTmTjwT/k=
Received: from BYAPR21MB1221.namprd21.prod.outlook.com (2603:10b6:a03:107::12)
 by BYAPR21MB1221.namprd21.prod.outlook.com (2603:10b6:a03:107::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1943.3; Sat, 1 Jun
 2019 22:59:56 +0000
Received: from BYAPR21MB1221.namprd21.prod.outlook.com
 ([fe80::d005:4de8:ffbf:ba6b]) by BYAPR21MB1221.namprd21.prod.outlook.com
 ([fe80::d005:4de8:ffbf:ba6b%7]) with mapi id 15.20.1943.015; Sat, 1 Jun 2019
 22:59:56 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     YueHaibing <yuehaibing@huawei.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "sashal@kernel.org" <sashal@kernel.org>,
        Dexuan Cui <decui@microsoft.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: RE: [PATCH] PCI: hv: Fix build error without CONFIG_SYSFS
Thread-Topic: [PATCH] PCI: hv: Fix build error without CONFIG_SYSFS
Thread-Index: AQHVF8LqT31hu0oy4EC9yHNNMbYtz6aGQ4zQ
Date:   Sat, 1 Jun 2019 22:59:56 +0000
Message-ID: <BYAPR21MB12211EEA95200F437C8E37ECD71A0@BYAPR21MB1221.namprd21.prod.outlook.com>
References: <20190531150923.12376-1-yuehaibing@huawei.com>
In-Reply-To: <20190531150923.12376-1-yuehaibing@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=mikelley@ntdev.microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2019-06-01T22:59:54.1676311Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=0e76142d-58b5-4ed7-bcde-8854964c8780;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=mikelley@microsoft.com; 
x-originating-ip: [24.22.167.197]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a4ab7b9d-d25e-40d3-a23a-08d6e6e4ddb7
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:BYAPR21MB1221;
x-ms-traffictypediagnostic: BYAPR21MB1221:
x-microsoft-antispam-prvs: <BYAPR21MB12215469F4F965808C78C289D71A0@BYAPR21MB1221.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 00550ABE1F
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(396003)(346002)(39860400002)(136003)(376002)(199004)(189003)(186003)(74316002)(229853002)(5660300002)(66476007)(66066001)(52536014)(66446008)(2906002)(256004)(22452003)(68736007)(6436002)(6116002)(11346002)(10090500001)(1511001)(76176011)(478600001)(486006)(2501003)(26005)(33656002)(476003)(9686003)(55016002)(446003)(316002)(8676002)(64756008)(76116006)(6246003)(14454004)(81156014)(71200400001)(66946007)(66556008)(8990500004)(53936002)(7736002)(86362001)(8936002)(71190400001)(305945005)(25786009)(73956011)(54906003)(7696005)(81166006)(10290500003)(6506007)(3846002)(4326008)(99286004)(110136005)(52396003)(102836004);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR21MB1221;H:BYAPR21MB1221.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: C4Y7O9stUinpPoHXFU9OYB3+n/CMkQYw6eItoBXj4T7AqdOGbpclD3v16eYbKB7FFxdhf7N6aIsVNyXWPuE+jgKa2dFYKChc5g02NS1X5YI5mQ9xSWZwTKjpjslc7Xi5f2JLDnK2JRkrZ3+yG6OwTLnTMjI5IvOC2Jq0g4kx3hhNt66vU6+2yC+NUgLu15dU6lK/EcEmivt8Y3ZSbnUSWrTkvBDhqwhw/0UNneqI4814FTUSprM+yuNdhzcqulQ9f9ULPy76/CCURB02wdN4GKe++z050Sdeiwukj/lRRY2FyrmSatRB7T3nb7olpDb/wFftWQDPSBFKlIRWaUl30Qscb+T0zopTNIv1APu65rnapKTGlVWJaW7/j4Gj75anJ/sFUQqOiRTCL8B7McPHnFkILYOF5Pn0e+zm/y7FHRg=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a4ab7b9d-d25e-40d3-a23a-08d6e6e4ddb7
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jun 2019 22:59:56.4076
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mikelley@ntdev.microsoft.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR21MB1221
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: YueHaibing <yuehaibing@huawei.com>  Sent: Friday, May 31, 2019 8:09 A=
M
>=20
> while building without CONFIG_SYSFS, fails as below:
>=20
> drivers/pci/controller/pci-hyperv.o: In function 'hv_pci_assign_slots':
> pci-hyperv.c:(.text+0x40a): undefined reference to 'pci_create_slot'
> drivers/pci/controller/pci-hyperv.o: In function 'pci_devices_present_wor=
k':
> pci-hyperv.c:(.text+0xc02): undefined reference to 'pci_destroy_slot'
> drivers/pci/controller/pci-hyperv.o: In function 'hv_pci_remove':
> pci-hyperv.c:(.text+0xe50): undefined reference to 'pci_destroy_slot'
> drivers/pci/controller/pci-hyperv.o: In function 'hv_eject_device_work':
> pci-hyperv.c:(.text+0x11f9): undefined reference to 'pci_destroy_slot'
>=20
> Select SYSFS while PCI_HYPERV is set to fix this.
>=20

I'm wondering if is the right way to fix the problem.  Conceptually
is it possible to setup & operate virtual PCI devices like=20
pci-hyperv.c does, even if sysfs is not present?  Or is it right to
always required sysfs?

The function pci_dev_assign_slot() in slot.c has a null implementation
in include/linux/pci.h when CONFIG_SYSFS is not defined, which
seems to be trying to solve the same problem for that function.  And
if CONFIG_HOTPLUG_PCI is defined but CONFIG_SYSFS is not,
pci_hp_create_module_link() and pci_hp_remove_module_link()
look like they would have the same problem.  Maybe there should
be degenerate implementations of pci_create_slot() and
pci_destroy_slot() for cases when CONFIG_SYSFS is not defined?

But I'll admit I don't know the full story behind how PCI slots
are represented and used, so maybe I'm off base.  I just noticed
the inconsistency in how other functions in slot.c are handled.

Thoughts?

Michael
