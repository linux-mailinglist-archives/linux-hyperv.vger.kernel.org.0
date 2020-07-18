Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73FC2224856
	for <lists+linux-hyperv@lfdr.de>; Sat, 18 Jul 2020 05:46:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727043AbgGRDqZ (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 17 Jul 2020 23:46:25 -0400
Received: from mail-eopbgr1310105.outbound.protection.outlook.com ([40.107.131.105]:23376
        "EHLO APC01-SG2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726923AbgGRDqZ (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 17 Jul 2020 23:46:25 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NZyaiiGUMcX7mrsYf0Qrs32PdSa9cgt/7c4/sMc1ewjfujuADYAGKsnQ8qP676I2iLgLSZKoWcWehiQM+j/sC1ukF83tn7DlpKA8SanKBL0gDLfEfSBChEdScWCsQSKqKPOzrkVB4jNl4nbxrrXPkxoHBD3F/bLBDqN53fEc6/Lm0a8UvJellyd1DOoNaJDixNTMQcC93dQ0z/AmGb77MHPwm9B2g4H+wzBYMQ8/JLqdRGc1GelTg1HQcfCUeT3hpqVWzMN/AIFE14i/94qTBHtcq+nx0wTsi1FACLgkGwFhroCgdbxjalaIKsgfrMnPeVKo+7W6mp/RSJY5a17CAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rLKCYw8VV/N9EdoeyVmckeNf5TPWjTFK4cZiHI1SoHI=;
 b=UhG8jPzvvnJTGVLYLyMiiZcR+fxHADT42RjWqEDq+TpJ4rlD969A/yOyEnB3NsTqHAQJJxEpB0KiiNiQor70dzfDkkPcRkZLny/TjLrCn2qRU93ka14jIR0AabADcSFai1cInmM74ijWuLpw2Z+/C9RMqQrUrjlfpSae1ZmOc5T6gM9kEOOGn8RNmypyDo3Ma+v+iDVvplEFT5PmiasQNbNbES7/8YU7cX6tzB7S7rpiKdR0+0TQGpbUAdvlWRjhrMGepI7DZFKZguvQ4t7KOlJFJy+2GZDgUpx4Ebi4FLovO/fDCqYn1FnsiIjM5jd7K+bTPQBLHQj7yYh+zoryPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rLKCYw8VV/N9EdoeyVmckeNf5TPWjTFK4cZiHI1SoHI=;
 b=bnwR/gzptv5VXCIOl5dw/LmfGrdehsG9RhwimdvxlwQ7wytu2Vu7cFAlXM6m/yKdu62ZsfLihIUaPb4yLesE3EkLhyTE/22bUsnZAnYAUmBfEHYheReRt+CQvG/V96rKg4RnCi3D8vwe7XmX4d+/NkgnKBgpgogrHnxQjA7xg70=
Received: from SG2P153MB0377.APCP153.PROD.OUTLOOK.COM (2603:1096:0:1::15) by
 SG2P153MB0269.APCP153.PROD.OUTLOOK.COM (2603:1096:4:ad::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3216.7; Sat, 18 Jul 2020 03:46:19 +0000
Received: from SG2P153MB0377.APCP153.PROD.OUTLOOK.COM
 ([fe80::b5e5:3111:30f0:8e01]) by SG2P153MB0377.APCP153.PROD.OUTLOOK.COM
 ([fe80::b5e5:3111:30f0:8e01%3]) with mapi id 15.20.3216.014; Sat, 18 Jul 2020
 03:46:19 +0000
From:   Wei Hu <weh@microsoft.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
CC:     KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "robh@kernel.org" <robh@kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Dexuan Cui <decui@microsoft.com>,
        Michael Kelley <mikelley@microsoft.com>
Subject: RE: [PATCH v2] PCI: hv: Fix a timing issue which causes kdump to fail
 occasionally
Thread-Topic: [PATCH v2] PCI: hv: Fix a timing issue which causes kdump to
 fail occasionally
Thread-Index: AQHWW+XQ2YjcaVAJF02S1C4ls9CN5qkMNRgAgAB9PiA=
Date:   Sat, 18 Jul 2020 03:46:19 +0000
Message-ID: <SG2P153MB0377A7193C7038BD1512EACCBB7D0@SG2P153MB0377.APCP153.PROD.OUTLOOK.COM>
References: <20200717025528.3093-1-weh@microsoft.com>
 <20200717201124.GA767548@bjorn-Precision-5520>
In-Reply-To: <20200717201124.GA767548@bjorn-Precision-5520>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2020-07-18T03:46:16Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=ec2a9284-60c7-463e-a55c-3fff1b0d5c72;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=microsoft.com;
x-originating-ip: [122.225.129.82]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 18d9812a-8f29-4b06-24a6-08d82acd21af
x-ms-traffictypediagnostic: SG2P153MB0269:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SG2P153MB0269203693BF3A8F1AA89168BB7D0@SG2P153MB0269.APCP153.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:3276;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: uTb7dJEr+jHc1skdvKdn49lU64vciF2BwImcmWLA9BYtjjSRKg7Wfqs1wwy6GPoHqYLMaZt+UXREqDafCTW5GnY81qNz1SBAHo0Uu3QHhpoZQOiiTNoj7UDhWQCTbeUQ4r5UeyzImU/AwQQcyIA2y6OItO/NHOln+kFaM0khYAGrm6rOaS2tvIMZAoegKEBnLYCcqyCOxlKbSiASLR2c1Jh2p1Bt+UwwuPB3H/5G4gG8AKQGKn8mtfgqb5Krbm+p1lo6qVi0TRnyUfbYTgN/2XtivPidLPV+7VwQiJA8eu32jE+LQs1Pb+HmD0Sky73e75cixN7wqIwP8waN1mWejg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2P153MB0377.APCP153.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(396003)(136003)(366004)(376002)(39860400002)(346002)(53546011)(82950400001)(107886003)(55016002)(8676002)(8936002)(7696005)(8990500004)(10290500003)(26005)(4326008)(6916009)(9686003)(186003)(86362001)(83380400001)(66946007)(5660300002)(54906003)(6506007)(316002)(82960400001)(66476007)(33656002)(71200400001)(64756008)(76116006)(2906002)(52536014)(66556008)(66446008)(478600001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: A8LnXVTg8VxGhBUfOcCsTu3nIcFWAIQEsSkDvv6xy9QpW3KeYo1QtznJnkygfkLGNnmKScbgVECXA2NooU8iZ8wcZyr5XSSvjLqeiZUfj6SWYI36lji2GtpmN7gWU7kLTh4BGHqaF36mvF1iTAIJR6Md3QBEX8W5i5SGotH1bm9KVxqJgiA7TQFJDtnGVB/6/S3KF/jB9kk5V9nIAIEEeczTpijW12OpZDcSoJTPsaea3QsKZHibLgWuSKDWYqYlcHFPALDfsJKdyOg9xkUA8dEfCcMsIZXbpQbXWL1SqvYofkLJwTw/sUef2rxou1NbaWggz+FCZkOfRNT/47OqIoc8m8fFIYVftrcvnFflf8S5qknxWEER8ryJpAsXaNBH5sPDq4gGFRubtJHIX28k7nly2HnkxMxgVUqnBqD1RlloOkysdnuUVwH9J8Oaasc1baHNQ9yIqcMLKx3+GnfZMDS0QTXuG27uGYVI6Hgg+kmgr1IQ0m6pXgwNs0EFcjh3
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SG2P153MB0377.APCP153.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 18d9812a-8f29-4b06-24a6-08d82acd21af
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jul 2020 03:46:19.0571
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wtF1fQSl29RP7CyP7dull4gUPNFuz2qNALIymTi7ZypsleHXpQ3WTeL90RJWewXU2kJNyEd1glvH/YnQ5rBagQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2P153MB0269
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org



> -----Original Message-----
> From: Bjorn Helgaas <helgaas@kernel.org>
> Sent: Saturday, July 18, 2020 4:11 AM
> To: Wei Hu <weh@microsoft.com>
> Cc: KY Srinivasan <kys@microsoft.com>; Haiyang Zhang
> <haiyangz@microsoft.com>; Stephen Hemminger <sthemmin@microsoft.com>;
> wei.liu@kernel.org; lorenzo.pieralisi@arm.com; robh@kernel.org;
> bhelgaas@google.com; linux-hyperv@vger.kernel.org; linux-
> pci@vger.kernel.org; linux-kernel@vger.kernel.org; Dexuan Cui
> <decui@microsoft.com>; Michael Kelley <mikelley@microsoft.com>
> Subject: Re: [PATCH v2] PCI: hv: Fix a timing issue which causes kdump to=
 fail
> occasionally
>=20
> On Fri, Jul 17, 2020 at 10:55:28AM +0800, Wei Hu wrote:
> > Kdump could fail sometime on HyperV guest over Accerlated Network
> > interface. This is because the retry in hv_pci_enter_d0() relies on an
> > asynchronous host event to arrive guest before calling
> > hv_send_resources_allocated(). This fixes the problem by moving retry
> > to hv_pci_probe(), removing this dependence and making the calling
> > sequence synchronous.
>=20
> Lorenzo, if you apply this, can you fix this typo?
>=20
>   s/Accerlated/Accelerated/
>=20
> and maybe even
>=20
>   s/HyperV/Hyper-V/
>   s/This fixes the problem/Fix the problem/
>   s/this dependence/this dependency/
>=20
> Not sure if "relies on ... event to arrive guest" means "relies on ...
> event arriving in the guest"?  Or maybe "relies on ... event arriving bef=
ore the
> guest calls ..."?
>=20
> This would probably all make perfect sense to me if I understood more abo=
ut
> Hyper-V :)
>=20
> > v2: Adding Fixes tag according to Michael Kelley's review comment.
>=20
> There's no need to include this "v2" comment in the commit log.  I think =
if you
> put it after a line containing only "---" (or maybe "--"?), it will be in=
 the email
> but not in the commit log.
>=20
Thanks Bjorn. I will send out a v3 version shortly to correct all these.=20
Lorenzo, please pick up my v3 version if you have not started to apply it y=
et.=20

Thanks so much,
Wei
