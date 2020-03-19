Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CD20418BA59
	for <lists+linux-hyperv@lfdr.de>; Thu, 19 Mar 2020 16:07:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727916AbgCSPGi (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 19 Mar 2020 11:06:38 -0400
Received: from mail-mw2nam10on2117.outbound.protection.outlook.com ([40.107.94.117]:48032
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727858AbgCSPGh (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 19 Mar 2020 11:06:37 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R8NuPuJvrMcVr01sEYMaIYqkNUdrn2ySH2ebDLmVXkOU9DkRhneJOgeS/emrUEE+2b2SZjJEqkfc0sQ4Q1K9KD579nSLFJX+nsRNy3r9BYpkRIBnsfidYht+D0mWxp1WECmCjbrD8aX18XeqV1mw0eJy9G1HVwxOBJMLmXcZicRDvfV8nkMt0Zwre6kXacbEhueCYuT9c4mai3S6U2A94HslyiuTZYXZPS6WOvAh7zBgIOSnFK+p5pxLdJE2Y9v2A6E6DwdZrYkz8iYjNabpj41qL3ifSZWH7c2XfhW9Em1paeE0vKzZ3vKmZLKMHvZ7JDe5nRkPFFGX216qbRkKKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v6Er4kLWhx0NOeAcfresGXNuHMQOMKv74GDcSH0xmzY=;
 b=dbhKNYLy2ebtAHC8whhvlX6EfrNcwywq7/UqdO6b5DwXBQqQxScDEeii86waOssQY/UQLsuvzi5SgNxJ7rh0+9yEjLfSVuxTEwxqrVL2x+DjAgaPHViSp7cMlc1mtgQDUdVvR1F7b9Abhk91oSXXXHNfP+9Q8APufjvVZIhT6Uuv5/qSBNYp9CmBPF8CPUcoW63l/4kH64REwYxoAlVxro2eV12GgIcP0+oD8vXLiIuSouPK9Pdj/WD0oAxJBz5cVepdAzbk7nS1RqFzrJ6O/QWrpWriS+ukIzAwkXQWVUPaf233ClAnryhnxHIEDqxmkkmml0tYnNLvRuYhzAmZhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v6Er4kLWhx0NOeAcfresGXNuHMQOMKv74GDcSH0xmzY=;
 b=LN3McfeZsXy9l2LebLS1MyYi+oMjyfQKwOB7Cyg33xCszToZVIRqIxKhq8pIYQ9ZNY5Oe/vqRHldElmjf9640ciJ34L97RBsJVTcbOfUJlNeLBMJB8I/JDJx7xjz2QLpdfqqfUiGIkuehFY8ugt9XirnMZ+TxwsJvJuBil8yFaI=
Received: from MW2PR2101MB1052.namprd21.prod.outlook.com (2603:10b6:302:a::16)
 by MW2PR2101MB1081.namprd21.prod.outlook.com (2603:10b6:302:a::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.12; Thu, 19 Mar
 2020 15:06:35 +0000
Received: from MW2PR2101MB1052.namprd21.prod.outlook.com
 ([fe80::71ee:121:71bd:6156]) by MW2PR2101MB1052.namprd21.prod.outlook.com
 ([fe80::71ee:121:71bd:6156%10]) with mapi id 15.20.2856.003; Thu, 19 Mar 2020
 15:06:35 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     vkuznets <vkuznets@redhat.com>,
        "ltykernel@gmail.com" <ltykernel@gmail.com>
CC:     Tianyu Lan <Tianyu.Lan@microsoft.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <liuwe@microsoft.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>, "hpa@zytor.com" <hpa@zytor.com>,
        "x86@kernel.org" <x86@kernel.org>
Subject: RE: [PATCH 0/4] x86/Hyper-V: Unload vmbus channel in hv panic
 callback
Thread-Topic: [PATCH 0/4] x86/Hyper-V: Unload vmbus channel in hv panic
 callback
Thread-Index: AQHV/F+NpF+arxPCF0mdiFS5UJm0vqhOg1uAgACKLMCAAIObgIAAdb7w
Date:   Thu, 19 Mar 2020 15:06:35 +0000
Message-ID: <MW2PR2101MB10522D2935F49CB9AF138E02D7F40@MW2PR2101MB1052.namprd21.prod.outlook.com>
References: <20200317132523.1508-1-Tianyu.Lan@microsoft.com>
 <20200317132523.1508-2-Tianyu.Lan@microsoft.com>
 <871rpp3ba8.fsf@vitty.brq.redhat.com>
 <MW2PR2101MB10529A60AF5185BBD7B02E04D7F40@MW2PR2101MB1052.namprd21.prod.outlook.com>
 <87mu8c22ky.fsf@vitty.brq.redhat.com>
In-Reply-To: <87mu8c22ky.fsf@vitty.brq.redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=mikelley@ntdev.microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2020-03-19T15:06:33.6535463Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=e3602d56-2684-45f6-9486-9b060ca11974;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=mikelley@microsoft.com; 
x-originating-ip: [24.22.167.197]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: ce379de3-0271-44ed-a36b-08d7cc171de5
x-ms-traffictypediagnostic: MW2PR2101MB1081:|MW2PR2101MB1081:|MW2PR2101MB1081:
x-ms-exchange-transport-forked: True
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <MW2PR2101MB1081CD22156F42A593BE1689D7F40@MW2PR2101MB1081.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 0347410860
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(366004)(136003)(346002)(376002)(39860400002)(396003)(199004)(33656002)(81166006)(478600001)(10290500003)(8936002)(81156014)(8676002)(9686003)(186003)(55016002)(4326008)(26005)(5660300002)(110136005)(316002)(76116006)(2906002)(54906003)(66476007)(66556008)(64756008)(66446008)(66946007)(52536014)(8990500004)(7696005)(86362001)(71200400001)(6506007);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB1081;H:MW2PR2101MB1052.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: TEbcqDx08WKYKoeQlHASglYgrGI24B4gf1OksmhNbO65MtpQMd24MCMmurke1M9I81CIcX3e51pKf9OqPrvO1Y7V6xrIcNsUtU0gLIE5s1EnrFSgwoKqvVUYMhONOb2YqKpi15MittMq9vh+2r/IXYhMEEUupYjj24rFDIFDuswzGf0Id1j9tHXvdfSkJt3ls3FOJ3/ntjTHT+VvVfQavH6MnxjDKVXorSxksOAtTklqaJwVpHnlRsNwlumcbAn8ZaBdu9CCojcymXm9NEi28Ee4p32saKhq5P9zAzxJGq0VKttaID5lewaZV9CrG0hWe/dizDnTXjBQDgDfdsjpZPtmrMTErAfkdIUXsCQ2PyaZVWJjlv7lFMDrVJDI+4OyL3fY8bqVae61nHHsWxnsVLF9+ng93otRfyhVW0dwHMWHeKCcpZQjOW8LsQq/wLTD
x-ms-exchange-antispam-messagedata: PCtqtUHFCau+EJ1GVMj3L7EZesJrZ0kbb4TypqjHznf4bS6faJ1zKu8WUpoMzddXjArsOteKDhPFFgWoHJmJKFw3Op31GuuEzefs9tY4pxoAj+adwMtRD55K53ULTaBAMr1Z0tZE4E41bmV+Ua41CA==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce379de3-0271-44ed-a36b-08d7cc171de5
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2020 15:06:35.2628
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gF2SxsIcvZPz/jWo8Yc8agZbmn480jrM0zJ8bOr6Bqmf6Djq3HejUjQuHfuIOFttyzyFwCdQGLaVwWxUXN4zJwHOCsUzbs8xlWJyjx2ceLw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB1081
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Vitaly Kuznetsov <vkuznets@redhat.com>  Sent: Thursday, March 19, 202=
0 1:04 AM
>=20
> Michael Kelley <mikelley@microsoft.com> writes:
>=20
> >> > --- a/drivers/hv/vmbus_drv.c
> >> > +++ b/drivers/hv/vmbus_drv.c
> >> > @@ -53,9 +53,12 @@ static int hyperv_panic_event(struct notifier_blo=
ck *nb,
> unsigned
> >> long val,
> >> >  {
> >> >  	struct pt_regs *regs;
> >> >
> >> > -	regs =3D current_pt_regs();
> >> > +	vmbus_initiate_unload(true);
> >> >
> >> > -	hyperv_report_panic(regs, val);
> >> > +	if (ms_hyperv.misc_features & HV_FEATURE_GUEST_CRASH_MSR_AVAILABLE=
) {
> >>
> >> With Michael's effors to make code in drivers/hv arch agnostic, I thin=
k
> >> we need a better, arch-neutral way.
> >
> > Vitaly -- could you elaborate on what part is not arch-neutral?  I don'=
t see
> > a problem.  ms_hyperv and the misc_features field exist for both the x8=
6
> > and ARM64 code branches.  It turns out the particular bit for
> > GUEST_CRASH_MSR_AVAILABLE is different on the two architectures, but
> > the compiler will do the right thing.
> >
>=20
> Ah, apologies, missed the fact that we also call it
> 'HV_FEATURE_GUEST_CRASH_MSR_AVAILABLE' - I have to admit I was confused
> by the 'MSR' part. We can probably rename this to something like
> HV_FEATURE_GUEST_CRASH_REGS_AVAILABLE - but not as part of the series.
>=20

Good point.  Agreed.

Michael
