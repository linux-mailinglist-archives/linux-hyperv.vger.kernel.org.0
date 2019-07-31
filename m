Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F081C7B678
	for <lists+linux-hyperv@lfdr.de>; Wed, 31 Jul 2019 02:02:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725975AbfGaACB (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 30 Jul 2019 20:02:01 -0400
Received: from mail-eopbgr1320128.outbound.protection.outlook.com ([40.107.132.128]:24116
        "EHLO APC01-PU1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725963AbfGaACB (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 30 Jul 2019 20:02:01 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VNQnq5yeMLfm+hN8HwryihXl9rdd4gF44fs4CssJc1XsJuAklIt7D2mX94ljb/l//qxTtGS2TTUtWaCIFEgD2THsFrP460Mam/sPM3Fv7AFUEWKMi5GcMrUDfC+PyeFfzRPNJrPjjgG2uK5kYC+nSmobEmIE6kThxVwiXp9A/G//TqLUDeXeVQvJ82hWJrwwZpoXU22dgunfddK24fb7LGA7Ke0i9Gb9yNoRwY8/nzhPGvHjGFHVmyfF3XsieN9tSI3UclSBhPXsFu5lzhm53Vo/wABX1wQOSXQXArqkzhlC4kkiRrYVwJIKK49FgKpZQpo1P2BcwuVge9NITmAGIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jzz95LBFIJrL6xBzkE+B76DFnho7C3P9aVmv+L7IsMI=;
 b=juWXnnQ3++xibZ0w0UD31u/ZP3G6qOrKo58P7+qa2TaSxr8UulJXpapR41//RrRl+AYG8Pk6tPJWTk/m16dUY35q2Xwz+cB0dgAq/Nnve1f5IdRqITAFNZqoGUGgS5nZeI6r4hZxLfKn406ozdj1adg+uSCtErp/CsGPGIurmmLFCZJVr6KpI3lRbBapHG7OL9GLJpg/YJ08bcV7RJq9/17bMiVBPteWBBRXwLNQuVXoiXxYhaATAtLhS6EBb43pJ9L9Vy79g5c/5MZYzyJd+tGAWa5YDcS3H0i9LBnQTykJx7JOvvOc4p9htGxd3Hnx0zyOLkZamwlOjEE9W3hNYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jzz95LBFIJrL6xBzkE+B76DFnho7C3P9aVmv+L7IsMI=;
 b=cAMAwlX9qSeQw2DKGrxFMBPlVd8jga8HcYeH3mJT6fx+RfEW/r74j2DmneZ/WeB9cGVi2GFBp2rzJsjjT/X4gA46KPY4iEbZcnfDSzwdg2aNtpmrFZ7qjaPnybecSdceT112QAvB3SPNSW5E7h7mQ1YLlVmk7keZB+NNlbDBDlw=
Received: from PU1P153MB0169.APCP153.PROD.OUTLOOK.COM (10.170.189.13) by
 PU1P153MB0123.APCP153.PROD.OUTLOOK.COM (10.170.188.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2157.2; Wed, 31 Jul 2019 00:01:53 +0000
Received: from PU1P153MB0169.APCP153.PROD.OUTLOOK.COM
 ([fe80::d44e:57b7:d8fc:e91c]) by PU1P153MB0169.APCP153.PROD.OUTLOOK.COM
 ([fe80::d44e:57b7:d8fc:e91c%8]) with mapi id 15.20.2157.001; Wed, 31 Jul 2019
 00:01:53 +0000
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
Subject: RE: [PATCH 5/7] Drivers: hv: vmbus: Ignore the offers when resuming
 from hibernation
Thread-Topic: [PATCH 5/7] Drivers: hv: vmbus: Ignore the offers when resuming
 from hibernation
Thread-Index: AQHVNhdI4fE4dJaaXUuVBeGHWvZQDqbj5/pQgAANYeA=
Date:   Wed, 31 Jul 2019 00:01:53 +0000
Message-ID: <PU1P153MB01699A21E81D9E8E872A190ABFDF0@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
References: <1562650084-99874-1-git-send-email-decui@microsoft.com>
 <1562650084-99874-6-git-send-email-decui@microsoft.com>
 <MWHPR21MB078481A7C7F65E0297135D41D7DC0@MWHPR21MB0784.namprd21.prod.outlook.com>
In-Reply-To: <MWHPR21MB078481A7C7F65E0297135D41D7DC0@MWHPR21MB0784.namprd21.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=mikelley@ntdev.microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2019-07-30T23:07:07.0047554Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=a8409ba6-e20e-47d4-80bf-1229879e616a;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=decui@microsoft.com; 
x-originating-ip: [2001:4898:80e8:1:c0f7:3271:ccd8:4d01]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 11eef7c6-cb65-4008-badf-08d7154a4b90
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:PU1P153MB0123;
x-ms-traffictypediagnostic: PU1P153MB0123:|PU1P153MB0123:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <PU1P153MB01233313ADFB0D85218D101EBFDF0@PU1P153MB0123.APCP153.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 011579F31F
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(366004)(346002)(396003)(39860400002)(376002)(136003)(199004)(189003)(4326008)(68736007)(52536014)(10090500001)(64756008)(10290500003)(25786009)(8990500004)(6436002)(99286004)(14454004)(7696005)(66446008)(86362001)(446003)(66946007)(76116006)(478600001)(186003)(66476007)(2501003)(229853002)(66556008)(476003)(11346002)(9686003)(6246003)(8936002)(22452003)(53936002)(2201001)(316002)(55016002)(1511001)(256004)(7736002)(14444005)(486006)(46003)(76176011)(5660300002)(74316002)(2906002)(102836004)(71190400001)(305945005)(71200400001)(110136005)(6506007)(8676002)(81166006)(81156014)(33656002)(6116002);DIR:OUT;SFP:1102;SCL:1;SRVR:PU1P153MB0123;H:PU1P153MB0169.APCP153.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: LPT8J8WC3AkcrVMPry0pIkneh/nQ+7lks2BjSbrSbpMDndFY5o11fKvLC9IZlWeIfs6GN0tJK14Z+ZZ7vHIkpcpGT+7CZxaZf4h7msRCz2WC8p7qy3SfgoPheNbpno835FpV0AZs/bdsXQqXg7usFv00UCntbD6Rx+QCCRdj6Fm09YE0v7TUt19haSQxC7lnV36Zwc88LQWrmgzWTJsBPFQUfPmbclkrdkvj7avYIJApYQ7/Ip++V4MPRX9xk3WVo4x15OC9ygio3zpz6IEfAGgI3SojRURGiLrE3LLbh9ONTMQ1mo/7GYAAxmYmknmJOzyTXmab3g4H0be1YknlGrXMUUMfq8/9XOzp0kuZPK3hM499a2U46N2XpZe5Mlh3SqnJxKCxkIYClXLGfrsmU2oOw2+Ps9WwT9pLt6vdL7k=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 11eef7c6-cb65-4008-badf-08d7154a4b90
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jul 2019 00:01:53.1366
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4O/d0Dk5M908t3Yx1eX3diin7U29f2NUL3OkLE1wwrJ3wOuVunJj/bnGojYfIHDUztz1f4M7ubFYep32sjvRhA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PU1P153MB0123
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

> From: Michael Kelley <mikelley@microsoft.com>
> Sent: Tuesday, July 30, 2019 4:07 PM
> > +
> > +	if (oldchannel !=3D NULL) {
> > +		atomic_dec(&vmbus_connection.offer_in_progress);
> > +
> > +		/*
> > +		 * We're resuming from hibernation: we expect the host to send
> > +		 * exactly the same offers that we had before the hibernation.
> > +		 */
> > +		offer_sz =3D sizeof(*offer);
> > +		if (memcmp(offer, &oldchannel->offermsg, offer_sz) =3D=3D 0)
> > +			return;
>=20
> The offermsg contains "reserved" and "padding" fields.  Does Hyper-V
> guarantee that all these fields are the same in the new offer after resum=
ing
> from hibernation?=20

Yes. I confirmed this with Hyper-V team. The reserved/padding fields don't =
change
across hiberantion. BTW, the fields are filled with zeros since they're not=
 used.

>  Or should a less stringent check be made?  For example,
> I could imagine a newer version of Hyper-V allowing a VM that was
> hibernated on an older version to be resumed.  But one of the reserved fi=
elds
> might be used in the newer version, and the comparison could fail
> unnecessarily.

Upon resume, Linux VM always uses the same version, which was used when the
VM firstly booted up before suspend, to re-negotiate with the host.
=20
> > +
> > +		pr_err("Mismatched offer from the host (relid=3D%d)!\n",
> > +		       offer->child_relid);
> > +
> > +		print_hex_dump_debug("Old vmbus offer: ", DUMP_PREFIX_OFFSET,
> 4,
> > +				     4, &oldchannel->offermsg, offer_sz, false);
> > +		print_hex_dump_debug("New vmbus offer: ",
> DUMP_PREFIX_OFFSET, 4,
> > +				     4, offer, offer_sz, false);
>=20
> The third argument to print_hex_dump() is the rowsize and is specified as=
 must
> be 16 or 32.

Thanks! I misunderstood the argument. I'll change it to 16.

Thanks,
-- Dexuan
