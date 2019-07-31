Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6D8997B69E
	for <lists+linux-hyperv@lfdr.de>; Wed, 31 Jul 2019 02:16:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728345AbfGaAQ0 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 30 Jul 2019 20:16:26 -0400
Received: from mail-eopbgr1300118.outbound.protection.outlook.com ([40.107.130.118]:35502
        "EHLO APC01-HK2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726210AbfGaAQ0 (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 30 Jul 2019 20:16:26 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D1VU4oVxnpL9si1NGddJ5NnTYRp8I+XpwPBQ69+IF/jiojNrcxtA5gqHpDFuvDFzk353PsQUP4MfxwbG3GCGKuJqta78WJadtj8eOzvHwC5p6/+UaTxruHfthC0zj1DxFIWQUi9NRBm991gL+uox7HPeE3jvtwbwu6ch5NzWiXdPNlrBY7DeRcFyyvUKaTZqltz3gYnglxPK37GXiwpTT1EtrYSOM181hlfKpS5Nf3dVtmKglk9OY0vmALErP/Q1K7q1zGK+VuTT/y5QA9qrTskT5UVTIyFN62eL6iu+MDzKtnPhGrzKa/LT7DhhAwexhedLhTXZDX7fwMRfxu48QA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TtDtO36V+3Pmq22b84VGHF9oJtVvdHW4DHssI+28WJE=;
 b=ejQa0Owt8BVYIula5GfaR7UG9/6gdKhlTf50jaGIwXCbWLkHIeVHb77vTKhR4HQINUw3wv2mjghvGrXSuHdj94Tr1WfL4BPn5Pn6mXHY1eCCmVDP8uUmQ/dEf0/TXywLTnxhlRGaznFnzvktF6O0XWLXu80jKYe2CL9zrpyPmii9UQKkk0Gnq0/0yO0aMNikKiq4JNLLhfJRBHOsBG25HrkNj6nB073QRu/QarPgeG/bPGbOGCxWA333LxgjpCgSfpNXrYPuPt06IDMvY/kA+ZYcXYuWnR2ef3P7YbQmaU8TaxP8RtPTfvKDFK6oDe2PPhRYfxwnXGI3Chz76poeXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TtDtO36V+3Pmq22b84VGHF9oJtVvdHW4DHssI+28WJE=;
 b=CoZ3XWw1GMZfC2qV+XS/dB2XZah1BU0bb+JzmFB6u3KB4skrbToGCmqX8XSBxOxW2RmEz2HBdEXLMAUf3thbJcT2uLfE1/zAbgMo2ke9lAxR2g51xEhVwmNbLyFVtT46RubtiziOAlMdu8j0yy1RhKVS+JG2DOpUAm9pRsui2as=
Received: from PU1P153MB0169.APCP153.PROD.OUTLOOK.COM (10.170.189.13) by
 PU1P153MB0171.APCP153.PROD.OUTLOOK.COM (10.170.189.15) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2157.2; Wed, 31 Jul 2019 00:16:17 +0000
Received: from PU1P153MB0169.APCP153.PROD.OUTLOOK.COM
 ([fe80::d44e:57b7:d8fc:e91c]) by PU1P153MB0169.APCP153.PROD.OUTLOOK.COM
 ([fe80::d44e:57b7:d8fc:e91c%8]) with mapi id 15.20.2157.001; Wed, 31 Jul 2019
 00:16:17 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     Michael Kelley <mikelley@microsoft.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>,
        "sashal@kernel.org" <sashal@kernel.org>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 6/7] Drivers: hv: vmbus: Suspend/resume the vmbus itself
 for hibernation
Thread-Topic: [PATCH 6/7] Drivers: hv: vmbus: Suspend/resume the vmbus itself
 for hibernation
Thread-Index: AQHVNhdJZWKYdNj8hk22NGM1tZCwVabj7olQgAAL3RA=
Date:   Wed, 31 Jul 2019 00:16:17 +0000
Message-ID: <PU1P153MB0169B839BF81829C6572C02CBFDF0@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
References: <1562650084-99874-1-git-send-email-decui@microsoft.com>
 <1562650084-99874-7-git-send-email-decui@microsoft.com>
 <MWHPR21MB078461F2DB6FE0A6D0647B70D7DC0@MWHPR21MB0784.namprd21.prod.outlook.com>
In-Reply-To: <MWHPR21MB078461F2DB6FE0A6D0647B70D7DC0@MWHPR21MB0784.namprd21.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=mikelley@ntdev.microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2019-07-30T23:25:35.5916184Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=3253bf88-42be-4c76-912a-1ac61c3e3840;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=decui@microsoft.com; 
x-originating-ip: [2001:4898:80e8:1:c0f7:3271:ccd8:4d01]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e6be4a90-6731-47c9-b890-08d7154c4e93
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:PU1P153MB0171;
x-ms-traffictypediagnostic: PU1P153MB0171:|PU1P153MB0171:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <PU1P153MB0171939B14CD83124582BF60BFDF0@PU1P153MB0171.APCP153.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 011579F31F
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(346002)(136003)(39860400002)(366004)(396003)(376002)(189003)(199004)(54534003)(6506007)(186003)(6246003)(46003)(8936002)(71200400001)(71190400001)(15650500001)(305945005)(2501003)(256004)(11346002)(10090500001)(478600001)(476003)(486006)(68736007)(14454004)(2906002)(74316002)(8990500004)(99286004)(102836004)(10290500003)(110136005)(6116002)(5660300002)(66946007)(66446008)(64756008)(229853002)(53936002)(66556008)(66476007)(76176011)(446003)(9686003)(76116006)(33656002)(81166006)(81156014)(4326008)(55016002)(52536014)(86362001)(7736002)(6436002)(1511001)(8676002)(25786009)(22452003)(2201001)(7696005)(316002);DIR:OUT;SFP:1102;SCL:1;SRVR:PU1P153MB0171;H:PU1P153MB0169.APCP153.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: zNnMIGRaEl0WKT2MG7rCoUnVMNyJ8P+k9ZD5qvDDpNDL7KWd1v+H9OM6lUB0MCQ/IJpfL7le+Hgmv/cLCmmO/ZBba0McEbGhw2Ihzj3GVkdnPg527bc7uBLwKu4k8LqMEAhg0UoNGZpEpK+sxgPSmBRHZ79dN+lL0m3+/7oXp6t4bxIu/lenV5uhFnkEu9CXRjDOG8pGVY9J2J8QbSHBERjn6KrepGfQbfm8OevT+Bs5anQDd095Tmpb6bLl5VtzwX1j22Ou0bI3LElr1qU5Hq4n78rv072qGpZSVWTSv47e84O1tiMS10GJhXETmXDvVTLqKGDoGYAXBV4m9R/HRoFcKIm8xsMDK70WtzMHs6FzCq80/iw+oy5w4cszSB1jk0dOIkgruMhMugQnSvIkjkFexitzhV8G0KDoeUA8yq4=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e6be4a90-6731-47c9-b890-08d7154c4e93
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jul 2019 00:16:17.1798
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 21JhzbnYu0OpO2tjx78u/MGUpzvLFtswyrx71iC6qNpGEZQaP24/raN2tFRW5z3cgEMg1GHcqC7nnX6r3Hrn5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PU1P153MB0171
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

> From: Michael Kelley <mikelley@microsoft.com>
> Sent: Tuesday, July 30, 2019 4:26 PM
> From: Dexuan Cui <decui@microsoft.com>  Sent: Monday, July 8, 2019 10:30
> PM
> >
> > This is needed when we resume the old kernel from the "current" kernel.
>=20
> Perhaps a bit more descriptive commit message could be supplied?

I'll use this as the new changelog:

Before Linux enters hibernation, it sends the CHANNELMSG_UNLOAD message to
the host so all the offers are gone. After hibernation, Linux needs to re-n=
egotiate
with the host using the same vmbus protocol version (which was in use
before hibernation), and ask the host to re-offer the vmbus devices.=20

> > +
> > +	ret =3D vmbus_negotiate_version(msginfo, vmbus_proto_version);
>=20
> I think this code answers my earlier question:  Upon resume, we negotiate
> the same
> VMbus protocol version we had at time of hibernation, even if running on =
a
> newer
> version of Hyper-V that might support newer protocol versions.  Hence the
> offer
> messages should not have any previously reserved fields now being used.  =
 A
> comment to this effect would be useful.

Ok, let me add a comment before the line.

I'll post a v2 of the patchset, including the "[PATCH 4/7]", which needs a =
small change.

Thanks,
-- Dexuan
