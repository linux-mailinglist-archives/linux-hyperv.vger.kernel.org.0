Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9C1FB46CF9
	for <lists+linux-hyperv@lfdr.de>; Sat, 15 Jun 2019 01:34:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726047AbfFNXeV (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 14 Jun 2019 19:34:21 -0400
Received: from mail-eopbgr1300104.outbound.protection.outlook.com ([40.107.130.104]:56610
        "EHLO APC01-HK2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725812AbfFNXeU (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 14 Jun 2019 19:34:20 -0400
ARC-Seal: i=1; a=rsa-sha256; s=testarcselector01; d=microsoft.com; cv=none;
 b=hlzXTWuOgEspVBFuxGxRAWiPsj0PPTe+urTKuXOJXuy62KQEX7KampUVGnPij/uwv9ytSkJ+JL/R/sjYMJ01ItGDehvuO7ttZ7h+/2ogPGLTWo01MMkjdKlsUkxrm/i3+R+igbLIKJs/p9FJZ8kZBqBQWTMRa2Cg7tMQPoutU/c=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=testarcselector01;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=98DQMG0pvSoaYuFr2gROAz8nsZYhAd8aOxrXjlOtUj0=;
 b=laNd1HytNsUiAfGrvtlc02RQ/F4S1nwJ0I6o9pJe2f0mNqLC1fWZwBVonLTJiY88udmpIfNv7rI37eFTfiLhkrCAtNsTTSWvWZVSEJUdxme/Squ1kD4ztEEQwRD5l1xsX5ZJRm2e/MMs9MpBWDZBzZe2rn9U71I5oFT8+ljUMds=
ARC-Authentication-Results: i=1; test.office365.com
 1;spf=none;dmarc=none;dkim=none;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=98DQMG0pvSoaYuFr2gROAz8nsZYhAd8aOxrXjlOtUj0=;
 b=f1HPAzwqb1tXZis1fjcAAM8mVaDsO6aioIs5Q105dG3/0vnUmZYPWGFaPWbMYMCGQVCCi+hwJaFeoveMb5Z6dzmdBzbp6Z8SUEcNWtbY8N674qXm6ubBWazYYovlFXSQssNqC1s+UML7Zo+ZCoGnHc8U3Kmsez0SFfvwOHOQJnw=
Received: from PU1P153MB0169.APCP153.PROD.OUTLOOK.COM (10.170.189.13) by
 PU1P153MB0124.APCP153.PROD.OUTLOOK.COM (10.170.188.138) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2008.0; Fri, 14 Jun 2019 23:34:05 +0000
Received: from PU1P153MB0169.APCP153.PROD.OUTLOOK.COM
 ([fe80::d896:4219:e493:b04]) by PU1P153MB0169.APCP153.PROD.OUTLOOK.COM
 ([fe80::d896:4219:e493:b04%4]) with mapi id 15.20.2008.007; Fri, 14 Jun 2019
 23:34:05 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     Russell King - ARM Linux admin <linux@armlinux.org.uk>
CC:     Michael Kelley <mikelley@microsoft.com>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
        "lenb@kernel.org" <lenb@kernel.org>,
        "robert.moore@intel.com" <robert.moore@intel.com>,
        "erik.schmauss@intel.com" <erik.schmauss@intel.com>,
        Russ Dill <Russ.Dill@ti.com>,
        Sebastian Capella <sebastian.capella@linaro.org>,
        Pavel Machek <pavel@ucw.cz>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
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
Thread-Index: AQHVIt2lUviLbUjfZEmzRslUu7e03qabnRQggAAYmbCAAAbhAIAADalg
Date:   Fri, 14 Jun 2019 23:34:05 +0000
Message-ID: <PU1P153MB0169C43993952984FADF1B85BFEE0@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
References: <1560536224-35338-1-git-send-email-decui@microsoft.com>
 <BL0PR2101MB134895BADA1D8E0FA631D532D7EE0@BL0PR2101MB1348.namprd21.prod.outlook.com>
 <PU1P153MB01699020B5BC4287C58F5335BFEE0@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
 <20190614223310.pwwoefu5qdvcuaiy@shell.armlinux.org.uk>
In-Reply-To: <20190614223310.pwwoefu5qdvcuaiy@shell.armlinux.org.uk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=decui@microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2019-06-14T23:34:00.8940315Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=2c396d4f-04f2-43d1-855c-f5c9751730e0;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=decui@microsoft.com; 
x-originating-ip: [2001:4898:80e8:f:a444:4515:ca58:8eeb]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7529d7fb-a51c-46a5-cd35-08d6f120ca73
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600148)(711020)(4605104)(1401327)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:PU1P153MB0124;
x-ms-traffictypediagnostic: PU1P153MB0124:
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <PU1P153MB01244B7F016BE0D462A55951BFEE0@PU1P153MB0124.APCP153.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0068C7E410
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(136003)(376002)(346002)(366004)(396003)(189003)(199004)(46003)(68736007)(186003)(8936002)(6116002)(8676002)(10090500001)(476003)(486006)(5660300002)(52536014)(86362001)(256004)(11346002)(66476007)(446003)(71200400001)(73956011)(14444005)(71190400001)(76116006)(66946007)(66556008)(64756008)(66446008)(14454004)(22452003)(54906003)(8990500004)(74316002)(33656002)(4326008)(99286004)(6246003)(6916009)(102836004)(6436002)(25786009)(9686003)(316002)(81166006)(81156014)(7736002)(305945005)(229853002)(76176011)(53936002)(7416002)(7696005)(2906002)(10290500003)(6506007)(478600001)(55016002);DIR:OUT;SFP:1102;SCL:1;SRVR:PU1P153MB0124;H:PU1P153MB0169.APCP153.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: foWTZclbDfhCQrSbglLmje6UrlgApJTZgEtDxlfr3l9sVZSNp38eD4wblSS2gGZUwNbvC57P8OMCsw2VNxt5gOq/HGgBOuqP0eAmlHrvHUv08AFctF992npKuoe5P0/1/AXzaZDyqIOlz4Lz9xF+6Wdiim4jixmo7BJ12a5kdysMqFniNVgkIYwDSCKYf0Girw/tSLZHL7QgxOdzVyCj5PqeyREKoHw1yyGIamhFz6HlizKPY8kkdUmmqiXgk4VbGiRxxPajB7mtphlQ9FDZtujgYZ5Lg7No4n6zYMj6j5xwPCPpZVNaBLb7pRowRmLM2SJ6bhSwOkcZ1Y3u3S3n/FeLXkqVbSyU3A58emiRn2gCvitZKxzvrZ1Js5EFZajb9izHh3aIKyJWEu/EsJNZEHdDvR+cbsHusaW3qE2HPb4=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7529d7fb-a51c-46a5-cd35-08d6f120ca73
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jun 2019 23:34:05.1721
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: decui@microsoft.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PU1P153MB0124
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

> From: linux-hyperv-owner@vger.kernel.org
> <linux-hyperv-owner@vger.kernel.org> On Behalf Of Russell King
> On Fri, Jun 14, 2019 at 10:19:02PM +0000, Dexuan Cui wrote:
> > It looks ARM does not support the ACPI S4 state, then how do we know
> > if an ARM host supports hibernation or not?
>=20
> Don't forget that Linux does not support ACPI on 32-bit ARM, which is
> quite different from the situation on 64-bit ARM.
>=20
> arch/arm/kernel/hibernate.c is only for 32-bit ARM, and is written with
> the assumption that there is no interaction required with any firmware
> to save state, and later restore state upon resuming.
>=20
> Or am I missing something?

Hi Russell,
Thanks for your reply and please excuse me for my ignorance of ARM.=20

So 32-bit ARM Linux can hibernate even if it doesn't support ACPI, but
I guess not all 32-bit ARM machines support hibernation? If my guess
is correct, is there any standard capability bit or something that can be
used to tell if an ARM machine supports hibernation? I'm purely curious. :-=
)

Do you imply 64-bit ARM Linux supports ACPI and the ACPI S4 state?
If not, how can we tell if a 64-bit ARM machine supports hibernation or not=
?

Thanks,
-- Dexuan
