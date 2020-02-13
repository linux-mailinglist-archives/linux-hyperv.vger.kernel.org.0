Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B4B0A15B874
	for <lists+linux-hyperv@lfdr.de>; Thu, 13 Feb 2020 05:17:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729670AbgBMERb (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 12 Feb 2020 23:17:31 -0500
Received: from mail-eopbgr1300102.outbound.protection.outlook.com ([40.107.130.102]:27835
        "EHLO APC01-HK2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729686AbgBMERb (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 12 Feb 2020 23:17:31 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l7GSy5+hoObbGvbRLKEeOXuIOIRsEIR7yKMJWezQF2/Eld5U+PlOE/cpdmYYniekVn4laMgU823etchY0t9ewmInCwGqFwt2Mc/yJGsNu9wnunuymboYLvNc++FlNbFHrYViVZ4S2JkjYccLyvGjuAIfIeyCy6pxPlzEeX2DzarS6M9x+q8iELb0gYCvRgeWmBAphQlmyEoWIXrsTv+eYYPHqJnIi2OVxTBE/GYusKbR4Mmc820N5XC3J9LVNWYFmCDUiKQ08sjIckt1Y9Sas/H8IIri8lO5zKqvwn0T8EiBfQGa5Rf5k2Uk7MsKdKaBGLHWqexHOiJAd9ojMT6VSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AjPDHydMM5OCKdL5LD/H+sNRu9fFGbR63k6wZVFbg8w=;
 b=Yu+uup9mDlTU5KTcf5JLCun/SLS6fSW+7fZxt1AVMKk6oX/q66JM8QARuHoEl7ntFugD74DxsnIRo08zVZRDqpHicbdBM67zaBuuLit9GNPy/M2NJlRkl3Y8frgEG6uhFEak6aab7OibGrDyshQ7teVh14B1PVI3u8Sy6APTC9/AYd3bFTY+kOLqyEGRZ56NaUulV186mG1AsX+zuejIEpRqNqysmDMo5Wk2+3rfWAl5o418YVXkYI0tyJe3dsUTyJFRbZjW5KLnsqkQZaNX7Jm+drAAMJFEWFDh1HACGLwVMlht0q/jm6Ks1C/hH7diuZcdQhWe9y57rfbBIaP69w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AjPDHydMM5OCKdL5LD/H+sNRu9fFGbR63k6wZVFbg8w=;
 b=SI8zjnzSLq+xG+BWwoEEByOaTbd9oxEBLpLDZjy+wa7c1X+nhCvlUa1wfaYNF6oH4RRRa/hlk1rgg7FWjUynzh/wVGXWDjPpzHVYNgkYiV5BmN/sbYAaU76ma4CEcwnjelfSEaMXAlVImfheceOXLPINZF/8CgrkxQYrOgM6yk4=
Received: from HK0P153MB0148.APCP153.PROD.OUTLOOK.COM (52.133.156.139) by
 HK0P153MB0290.APCP153.PROD.OUTLOOK.COM (52.132.236.143) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2750.2; Thu, 13 Feb 2020 04:17:20 +0000
Received: from HK0P153MB0148.APCP153.PROD.OUTLOOK.COM
 ([fe80::58ea:c6ae:4ea3:8432]) by HK0P153MB0148.APCP153.PROD.OUTLOOK.COM
 ([fe80::58ea:c6ae:4ea3:8432%5]) with mapi id 15.20.2750.007; Thu, 13 Feb 2020
 04:17:20 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     Boqun Feng <boqun.feng@gmail.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
CC:     Michael Kelley <mikelley@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Sasha Levin <sashal@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "x86@kernel.org" <x86@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Andrew Murray <andrew.murray@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Andrew Murray <amurray@thegoodpenguin.co.uk>
Subject: RE: [PATCH v3 1/3] PCI: hv: Move hypercall related definitions into
 tlfs header
Thread-Topic: [PATCH v3 1/3] PCI: hv: Move hypercall related definitions into
 tlfs header
Thread-Index: AQHV38PZZXF0IV9lxEadzQUsLnQj66gYge2Q
Date:   Thu, 13 Feb 2020 04:17:19 +0000
Message-ID: <HK0P153MB0148BC3F0BE758B7073B418EBF1A0@HK0P153MB0148.APCP153.PROD.OUTLOOK.COM>
References: <20200210033953.99692-1-boqun.feng@gmail.com>
 <20200210033953.99692-2-boqun.feng@gmail.com>
In-Reply-To: <20200210033953.99692-2-boqun.feng@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=decui@microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2020-02-13T04:17:17.9136161Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=f808b05e-3854-48eb-b9b9-5a2166ff3ade;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=decui@microsoft.com; 
x-originating-ip: [2601:600:a280:7f70:c129:4d3:3571:d407]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 1b099925-7f16-49a9-d0b1-08d7b03b9e7b
x-ms-traffictypediagnostic: HK0P153MB0290:|HK0P153MB0290:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <HK0P153MB029038BA464A64E92541FC43BF1A0@HK0P153MB0290.APCP153.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:5516;
x-forefront-prvs: 031257FE13
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(396003)(376002)(366004)(39860400002)(136003)(346002)(189003)(199004)(316002)(76116006)(5660300002)(7416002)(4744005)(64756008)(71200400001)(186003)(66556008)(52536014)(66946007)(7696005)(33656002)(8936002)(66476007)(66446008)(8676002)(81156014)(81166006)(6506007)(8990500004)(478600001)(54906003)(110136005)(10290500003)(2906002)(9686003)(86362001)(4326008)(55016002);DIR:OUT;SFP:1102;SCL:1;SRVR:HK0P153MB0290;H:HK0P153MB0148.APCP153.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wBVUr8KrlqJjYdWbI/7PsSH5+cU4t2a7xCpRF87XeyUxWUFCnmzSifVrFbz0AJ4+PR4jkCqSEvnbirdJjWFchrL9trlOKGo+6VN4OJ/c/1YqDwrcVpVpmspELO0nDTmpEvw1RVPrtsoOqBKoGUr/CaEeSUi81lZ5sVU3kZoUFQZ7DLY6n/ulXq+KdbrLg+VtSLr1tG8MTSWrJXj0KE0OzvTz4kxCxX5PQCnV2jLDq/xKCm9HJbG2WaDega3sQdpOC9FiFRqEWAaRhFq5egnC84ia9R2lwWtabXaAVQ6a5TawLog65ugg5oTeCF5B+Cq28RuC/FUedXFjgbATrbun47WBT8G/6H8OCLSr4edUP/9/MgyvpLZXMEedUp1ZBJnz7WxrPjflZAvbasC7KG/iJB2HXh8alHV3+Dc8K2uv3W+6oE6bCoCudrewJrOOaoS3
x-ms-exchange-antispam-messagedata: YUXPLk0jISFsmOmItNonV4HgaQRpUqM+y+qzxb36WaeWM0MyDOnZJmVl4gRld/og8gctM6aIVCpcAFdx4Wt0UvuSaqYE+YvVJjo2/EQdz/TPFjhGs1VDAP38f3fP2L+eYlgXVp+136MsB407Fc1jCFSQx01BapO0AdayqM2u/4GJ1GqGmsfuPNcChhQ4Tmr+j+kXlO6yhbjKIz4Izn5AEg==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b099925-7f16-49a9-d0b1-08d7b03b9e7b
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Feb 2020 04:17:19.9980
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bDn8b0x93AB0qAbZ6nZc6+Alm3gOYIxqZ87eEanEHexwLajf1BJ/Z39NWWnxBXeKr+g5+I2cZcngfrYogvKWZw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK0P153MB0290
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

> From: linux-hyperv-owner@vger.kernel.org
> <linux-hyperv-owner@vger.kernel.org> On Behalf Of Boqun Feng
> Sent: Sunday, February 9, 2020 7:40 PM
>=20
> Currently HVCALL_RETARGET_INTERRUPT and HV_PARTITION_ID_SELF are
> defined
> in pci-hyperv.c. However, similar to other hypercall related
> definitions, it makes more sense to put them in the tlfs header file.
>=20
> Besides, these definitions are arch-dependent, so for the support of
> virtual PCI on non-x86 archs in the future, move them into arch-specific
> tlfs header file.
>=20
> Signed-off-by: Boqun Feng (Microsoft) <boqun.feng@gmail.com>
> Reviewed-by: Andrew Murray <amurray@thegoodpenguin.co.uk>

Reviewed-by: Dexuan Cui <decui@microsoft.com>


