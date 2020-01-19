Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ED1A31420F1
	for <lists+linux-hyperv@lfdr.de>; Mon, 20 Jan 2020 00:35:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728886AbgASXfl (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Sun, 19 Jan 2020 18:35:41 -0500
Received: from mail-eopbgr1320123.outbound.protection.outlook.com ([40.107.132.123]:19722
        "EHLO APC01-PU1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728841AbgASXfl (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Sun, 19 Jan 2020 18:35:41 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FFw3AFSNDBNRE3l5CQ/5YmBVBTC4jGd9GhWP97sjk49dZTBGQjg1YS5uB+TXha05NgpDzPg5GgbN5JUXRs9mfYFJkrEMUv6PgYW3jlh++V0SO7hy80KtBbWRHoZR0EbyAoLpGXVGKPZG3XDOQxzzzdIFWXvALKzSGzuVHi33SvGpKVlul0018A493M7sBjKgSCtELyuNWNpxErzAxSVN6B2ZNBwlv4/tOlUl/x3VdH7wNP5FyRXO3QCmPve3tQOIOg4x1In7dF2W0KhmLGrDqMKMtr+0pz618ESaizyLzylx1zQJ69+fEdGXU3mAtMAt4YWo3kbDoohU2qN2VAbaZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RhIfHI3jlrgTPUVnPwjXDUJnZIwaDGpH/59vf/aB69c=;
 b=ULyiByKCc+6LEocENvwWbY6+xfjXSMVCAp6Jj1cVps5QVSU5sSG/+E8CcNFmczlJnbRZHsiExWPuSHzIj/HxKPvTCvocGUO+8wba+pikoXBeIwkfJlCpvLd5rcICUpizW9L4fiOaTqSC2pyXHvpWwNEapj+UZY4ESy4HAI4A+DjlRkqWnQz8GkqF4DHN821HIa56XS8EVSsuroK+/Ova7x1nC4piZoViysVTQp8yGQ1SDsQHLXOqoBZXSPZx8AnzkT55WKNFZOxFP+VlzxrXIaM05SghIiKB2npIYSGYemLXBNbb4IWtvsTFMRdKd678YHg94NLRxdm8jZhZF4GRpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RhIfHI3jlrgTPUVnPwjXDUJnZIwaDGpH/59vf/aB69c=;
 b=VH4BC02kvqef46783dZU/liZf83ffXU7HbLXpKVuTXrEP0W3kOl36bUzneWBHrXZY/59NwPafGxEE3pgVzQEEJcYLJ9AtyyP1GBtU6oG2IjWj0xagGy4Qw5E7cNuX04Tb50U1Lckedo3cnU7BTm1Ew7kG6ZAkLpUpvB8060ioGk=
Received: from HK0P153MB0148.APCP153.PROD.OUTLOOK.COM (52.133.156.139) by
 HK0P153MB0147.APCP153.PROD.OUTLOOK.COM (52.133.156.138) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2665.11; Sun, 19 Jan 2020 23:35:32 +0000
Received: from HK0P153MB0148.APCP153.PROD.OUTLOOK.COM
 ([fe80::f964:752b:ffde:dec7]) by HK0P153MB0148.APCP153.PROD.OUTLOOK.COM
 ([fe80::f964:752b:ffde:dec7%8]) with mapi id 15.20.2665.014; Sun, 19 Jan 2020
 23:35:32 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     Michael Kelley <mikelley@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "sashal@kernel.org" <sashal@kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
CC:     Sunil Muthuswamy <sunilmut@microsoft.com>,
        Andrea Parri <Andrea.Parri@microsoft.com>
Subject: RE: [PATCH] Drivers: hv: vmbus: Ignore
 CHANNELMSG_TL_CONNECT_RESULT(23)
Thread-Topic: [PATCH] Drivers: hv: vmbus: Ignore
 CHANNELMSG_TL_CONNECT_RESULT(23)
Thread-Index: AQHVziTPYp9SoZnuM0e6zqOwmV+YqafypUbA
Date:   Sun, 19 Jan 2020 23:35:32 +0000
Message-ID: <HK0P153MB01480CADCA0A021A78C874C3BF330@HK0P153MB0148.APCP153.PROD.OUTLOOK.COM>
References: <1578619515-115811-1-git-send-email-decui@microsoft.com>
 <MW2PR2101MB10524758141F09806D8677FCD7300@MW2PR2101MB1052.namprd21.prod.outlook.com>
In-Reply-To: <MW2PR2101MB10524758141F09806D8677FCD7300@MW2PR2101MB1052.namprd21.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=mikelley@ntdev.microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2020-01-18T17:29:15.8714183Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=c22cbd7b-5961-4cb1-a220-690f9063ebe2;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=decui@microsoft.com; 
x-originating-ip: [2001:4898:80e8:2:153d:a2e3:607d:8b29]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 5d4bf249-16b3-4d15-fa07-08d79d3846ea
x-ms-traffictypediagnostic: HK0P153MB0147:|HK0P153MB0147:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <HK0P153MB0147BAEE632FF9794F375A89BF330@HK0P153MB0147.APCP153.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 0287BBA78D
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(346002)(396003)(376002)(136003)(39860400002)(366004)(189003)(199004)(5660300002)(86362001)(6636002)(8936002)(7696005)(6506007)(33656002)(52536014)(71200400001)(316002)(478600001)(10290500003)(2906002)(110136005)(186003)(81166006)(76116006)(9686003)(107886003)(55016002)(66556008)(66446008)(64756008)(8676002)(66476007)(81156014)(66946007)(4326008)(54906003)(8990500004);DIR:OUT;SFP:1102;SCL:1;SRVR:HK0P153MB0147;H:HK0P153MB0148.APCP153.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: u6TsCYDcHBbI+jl4GJjHO47cZq5ZrxSBB3eHR9Y8psqaqlylsALc5N1STGWwGrcyeJJoFxlTroXtFaNQSDkJnHgCshjnGPp6GDiSDl8wXX9mWfCNMf3cdkh3C29zc0uboSskGdrC5DpI5htikpQpQF33j8cbzYdGmu5yGSwI2CfAhnI9kp+8CVFyBZeFsCfgWP+21/OMR/CL05B1IB8F7eJz5Nsy7MwoRm/mcNo7nhbT5ysrEZNB82jw0nWXVRJMvAzP5I4fA1kC+RdKKBWtxAgOFP93uhPI/CulpjsSX+IfUXMqTUkytLwIpaRZjH8WdEGw9qMQaFLG9CSQPue0xFU2tf5S+D6rDP3yn0J126re5/TGWDxtamSo1kvJDtKB12VnOm+bz03frgk2DLXC/NuhgTkrZX5hnnSOKVBu6oOYpepwfAG7dZ1GiVUU7u18
x-ms-exchange-antispam-messagedata: 6KLhXi7DA3RPIeszsbNTxUlax42EucWclu2JibBXFX+1YZv+76PafQFEZW+qQolN10XHevkHIO2M95Vhl/RxP1xOoCIEJXgle1M28Hlg57UVBSxn51IWQ2zwlAnFY/XsrGC6TNKDtOAlsYXB7seM4UYd1iXLQSB0gsZfVMRr4WyMZWcJx886NYdq9rBeviWPYijoiNekEt6uqj6Iv/RG3w==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d4bf249-16b3-4d15-fa07-08d79d3846ea
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jan 2020 23:35:32.5051
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JpAEOU7TopBroqwLbWP0e38HIlH8UZtpeEtSkt1/mDcZhLhpsDhXKPuxTOytPGBOhbqt1m1wMx3iDfJOGltVYQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK0P153MB0147
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

> From: Michael Kelley
> Sent: Saturday, January 18, 2020 9:29 AM
> > +
> > +	/* Linux ignores some messages, e.g.
> CHANNELMSG_TL_CONNECT_RESULT. */
> > +	if (!entry->message_handler)
> > +		goto msg_handled;
> > +
>=20
> FWIW, with this new check, all of the validity checks in vmbus_onmessage(=
)
> are redundant and could be removed.  There's already a check here that
> ensures msgtype won't be too big, and this new check ensures that=20
> message_handler is not NULL.

Agreed. I just sent a v2 that removes the redundant code.

> >  	if (entry->handler_type	=3D=3D VMHT_BLOCKING) {
> >  		ctx =3D kmalloc(sizeof(*ctx), GFP_ATOMIC);
> >  		if (ctx =3D=3D NULL)
> > diff --git a/include/linux/hyperv.h b/include/linux/hyperv.h
> > index 26f3aeeae1ca..41c58011431e 100644
> > --- a/include/linux/hyperv.h
> > +++ b/include/linux/hyperv.h
> > @@ -425,6 +425,8 @@ enum vmbus_channel_message_type {
> >  	CHANNELMSG_19				=3D 19,
> >  	CHANNELMSG_20				=3D 20,
> >  	CHANNELMSG_TL_CONNECT_REQUEST		=3D 21,
> > +	CHANNELMSG_22				=3D 22,
> > +	CHANNELMSG_TL_CONNECT_RESULT		=3D 23,
> >  	CHANNELMSG_COUNT
> >  };
>=20
> For completeness, I'd like to see the channel_message_table also updated
> with these new entries so that everything stays in sync and is explicitly
> defined.
>=20
> Michael

I fixed this in v2 as well.

Thanks!
Dexuan
