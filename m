Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 937FE4E10C
	for <lists+linux-hyperv@lfdr.de>; Fri, 21 Jun 2019 09:16:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726230AbfFUHQJ (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 21 Jun 2019 03:16:09 -0400
Received: from mail-eopbgr1320098.outbound.protection.outlook.com ([40.107.132.98]:36144
        "EHLO APC01-PU1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726008AbfFUHQJ (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 21 Jun 2019 03:16:09 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AeUcAgMbO8ZAt6d0/qGVwLqdRAfRu0hYjAtKKDzdhMsiSCROaIh1A36Qo18AxAWF6dDhnGLL/Xy3/r3ClAadDqkxlN3YZYqj3kTZ2Od5a0ugCHrVbJqIC1c3nzrW8KHSxrVRT3Ko5nSdZNguEBqMk383/dJBFW6AqGVE7eNaKSk+kUeRbkmDYyI3EbnYJj4XsMu2ojLoWGy5QqvNsBOXP1TqrOa1fYP49kkIQxpiF+42xaDfODy7XZ5Gccm+VC11mUyr24wtwYordHqTg5Gz+5qQfvxhm/k1DqS9Kex97c3erhGhcWO3IOzLzz6tUdTNrsdGqDvbysd1YXFlJKU3vQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Unt8Dg+vuqUA9gSK4AUZJpp2XO8rshPozLolP4/3+z0=;
 b=GVQzhLujA7vt0WSaWi+I+vzZID/BPNWeYTu65CAtnMCQo5wpdUcLERKdaHDzjUW8J+2lMFk1cQPu+MDQG1v4/Al3RlNE2h6WNUaviz3hLFjXTrunA99I5aoabndpAE8avIB5fBWkt+YklL5v8jwLB97vadJVrVLO13t6v/x34tA4cSAATxeSh5r3CWOPC2v0UyPD7upmDtkIXWtXd/1K94rWpIkOeLP9PmZXolbeCqpmfd1Sb3mhhOXnfpSDaeKE09tSsB2i4qjforu8vZtIcefkr5IJo9xpRK4PeNtfUZ0SO/8k26g8nVrhZvV5FYb+qinolwNnISHV1cpUmD6CPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=microsoft.com;dmarc=pass action=none
 header.from=microsoft.com;dkim=pass header.d=microsoft.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Unt8Dg+vuqUA9gSK4AUZJpp2XO8rshPozLolP4/3+z0=;
 b=jbf4KPE1fgpaglj0kdiuPGL380BUxf6p87mlaYdCWtcBcwppU2OKPhdk/IadBlVKkTiY4sVlwm4PytPI8zXPrTD/O68oLnMYXkqbQGKhpkxMKe6LMSfZZIHk4rd1Z3LhEZR6/bg1Szu+qUZPslOtWuJAiiUmz47NrtT3lyd33Xk=
Received: from PU1P153MB0169.APCP153.PROD.OUTLOOK.COM (10.170.189.13) by
 PU1P153MB0107.APCP153.PROD.OUTLOOK.COM (10.170.188.12) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2032.6; Fri, 21 Jun 2019 07:15:49 +0000
Received: from PU1P153MB0169.APCP153.PROD.OUTLOOK.COM
 ([fe80::19b8:f479:a623:509b]) by PU1P153MB0169.APCP153.PROD.OUTLOOK.COM
 ([fe80::19b8:f479:a623:509b%5]) with mapi id 15.20.2032.008; Fri, 21 Jun 2019
 07:15:49 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     Pavel Machek <pavel@ucw.cz>
CC:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
        "lenb@kernel.org" <lenb@kernel.org>,
        "robert.moore@intel.com" <robert.moore@intel.com>,
        "erik.schmauss@intel.com" <erik.schmauss@intel.com>,
        Russell King <rmk+kernel@arm.linux.org.uk>,
        Russ Dill <Russ.Dill@ti.com>,
        Sebastian Capella <sebastian.capella@linaro.org>,
        Michael Kelley <mikelley@microsoft.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        KY Srinivasan <kys@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>,
        "olaf@aepfle.de" <olaf@aepfle.de>,
        "apw@canonical.com" <apw@canonical.com>,
        "jasowang@redhat.com" <jasowang@redhat.com>,
        vkuznets <vkuznets@redhat.com>,
        "marcelo.cerri@canonical.com" <marcelo.cerri@canonical.com>
Subject: RE: [PATCH] ACPI: PM: Export the function
 acpi_sleep_state_supported()
Thread-Topic: [PATCH] ACPI: PM: Export the function
 acpi_sleep_state_supported()
Thread-Index: AQHVIt2lUviLbUjfZEmzRslUu7e03qabnRQggAAYmbCABFQwAIAALIpAgAQ7H4CAAOhCUA==
Date:   Fri, 21 Jun 2019 07:15:48 +0000
Message-ID: <PU1P153MB016948F8B81454D4A5C13136BFE70@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
References: <1560536224-35338-1-git-send-email-decui@microsoft.com>
 <BL0PR2101MB134895BADA1D8E0FA631D532D7EE0@BL0PR2101MB1348.namprd21.prod.outlook.com>
 <PU1P153MB01699020B5BC4287C58F5335BFEE0@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
 <20190617161454.GB27113@e121166-lin.cambridge.arm.com>
 <PU1P153MB016902786ABA34BD01430F83BFE50@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
 <20190620113057.GA16460@atrey.karlin.mff.cuni.cz>
In-Reply-To: <20190620113057.GA16460@atrey.karlin.mff.cuni.cz>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=decui@microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2019-06-21T07:15:45.2170027Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=522de71d-c779-4f12-ba15-bdb3bccf93af;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=decui@microsoft.com; 
x-originating-ip: [2601:600:a280:1760:f58c:4b5a:d34b:1e33]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2606ef1f-5fae-4a86-946c-08d6f61849aa
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:PU1P153MB0107;
x-ms-traffictypediagnostic: PU1P153MB0107:
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <PU1P153MB0107009764D9C54BB0CF136FBFE70@PU1P153MB0107.APCP153.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0075CB064E
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(346002)(136003)(366004)(39860400002)(396003)(189003)(199004)(66446008)(66556008)(66476007)(68736007)(446003)(476003)(11346002)(14454004)(86362001)(76116006)(46003)(486006)(66946007)(73956011)(6116002)(64756008)(52536014)(186003)(71190400001)(71200400001)(7416002)(5660300002)(6916009)(54906003)(53936002)(6246003)(102836004)(478600001)(229853002)(76176011)(4326008)(9686003)(74316002)(305945005)(6506007)(22452003)(7696005)(7736002)(316002)(10290500003)(6436002)(8936002)(256004)(14444005)(2906002)(8990500004)(55016002)(10090500001)(8676002)(81156014)(81166006)(25786009)(33656002)(99286004);DIR:OUT;SFP:1102;SCL:1;SRVR:PU1P153MB0107;H:PU1P153MB0169.APCP153.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: vBW/aPIAUhkLbSWTri2EJbv3qw3iYDZH0MPmuCD6tPt8bh7jgnOA+jat2Y5pzdC0rnYILUgNKGV8iv2EvYTxDQe8RjSCuX/KExQYrRkRa/CiUB+4UPCkkHYf+y3E2wQKJRzYbupf5Wqn0Vyf+Z4IraUF9Xzz+SOWOFIGjtCGHpQz3llmredR21hBbAzc+8TBl/9+t0t0EKhnf3RFC/LaRkgh2T4J89UxzzbIHvcRNJaQGj04KaSMX34UU9N67OVGkEQ43lyp15COrgyYV6mafOOziX9P2sr+NSchGBmGJpazVbt28Cet5F/A/+PoGzVBRFuDHLO55mCjW/ZaAtgKZID//YHMpGbyfoTsxTSHVO1TVQMG5oCSmut/+Ccru2/hjTlbesyyg6rTNNY2pktAKdKpg6ALi3HLMvrJhco/hAw=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2606ef1f-5fae-4a86-946c-08d6f61849aa
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jun 2019 07:15:48.8921
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: decui@microsoft.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PU1P153MB0107
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

> From: linux-hyperv-owner@vger.kernel.org
> > ...
> > When a Linux guest runs on Hyper-V (x86_32, x86_64, or ARM64) , we have=
 a
> > front-end balloon driver in the guest, which balloons up/down and
> > hot adds/removes the guest's memory when the host requests that. The
> > problem
> > is: the back-end driver on the host can not really save and restore the=
 states
> > related to the front-end balloon driver on guest hibernation, so we mad=
e the
> > decision that balloon up/down and hot-add/remove are not supported when
> > we enable hibernation for a guest; BTW, we still want to load the front=
-end
> > driver in the guest, because the driver has a functionality of reportin=
g the
> > guest's memory pressure to the host, which we think is useful.
> >
> > On x86_32 and x86_64, we enable hibernation for a guest by enabling
> > the virtual ACPI S4 state for the guest; on ARM64, so far we don't have=
 the
> > host side changes required to support guest hibernation, so the details=
 are
> > still unclear.
> >
> > After I discussed with Michael Kelley, it looks we don't really need to
> > export drivers/acpi/sleep.c: acpi_sleep_state_supported(), but I think =
we do
> > need to make it non-static.
> >
> > Now I propose the below changes. I plan to submit a patch first for the
> > changes made to drivers/acpi/sleep.c and include/acpi/acpi_bus.h in a f=
ew
> > days, if there is no objection.
> >
> > Please let me know how you think of this. Thanks!
>=20
> No.
>=20
> Hibernation should be always supported, no matter what firmware. If it
> can powerdown, it can hibernate.
>=20
> That is for x86-32/64, too.
> 						Pavel

Hi Pavel,
Yes, I totally agree hibernation should be always supported, as long as the
system can power down. This is also true for Linux guest running on
Hyper-V, when the pava-virtualized drivers are not loaded in the guest

However, unluckily the situation is a little different when the pava-virtua=
lized
drivers are loaded in the guest:

1) Old Hyper-V hosts are unable to support guest hibernation and these host=
s
don't support the virtual ACPI S4 state.

2) The recent Hyper-V host is able to support guest hibernation, but when
guest hibernation is used, the guest needs to disable some features in the
guest balloon driver, as I explained in the previous mail; on the other han=
d,
we also want to keep the ability to enable the features, so the Hyper-V guy=
s=20
decided to use the absence of the virtual ACPI S4 state to signify the abil=
ity
of enabling the features, and there is a host command tool which can
enable or disable the virtual ACPI S4 state for a guest.

In summary:
1) On old Hyper-V hosts or a recent host, the virtual ACPI S4 state is
unsupported or disabled, respectively, and we don't allow Linux guest
hibernation so we can use the full features of the guest balloon driver.

2) On a recent host, after we use the host command tool to enable the
virtual ACPI S4 state, we allow Linux guest hibernation and we only use a
subset of the full features of the guest balloon driver.=20

This is why I need to know if the virtual ACPI S4 state is supported-and-en=
abled.

Exporting acpi_sleep_state_supported() may be overkill, and now making it
non-static seems the only way to help me out. IMO the function is unlikely
to change in the future, and it should be stable enough to become non-stati=
c.

Looking forward to your insights!

Thanks,
-- Dexuan
