Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7957D39B529
	for <lists+linux-hyperv@lfdr.de>; Fri,  4 Jun 2021 10:49:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229958AbhFDIvf (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 4 Jun 2021 04:51:35 -0400
Received: from mail-dm6nam12on2130.outbound.protection.outlook.com ([40.107.243.130]:12832
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229930AbhFDIve (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 4 Jun 2021 04:51:34 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K/JiG7f/K2wT9xvCiAjZqBiC5Ufca4h5mTxgRITQ5K/XFtKC7Haxv18DLIo0f5mr9q+OWyBDc9YTYpUFwAiLIGgpAv3hiX148Fiw/8YyLaZpZTu11phxVK62BMt2nEcrkUczss7vAE4wOBAI1HnNh0ateO9lLi9hm+kz5+bDCh0//spN1KT7WTT5LRiIK1R8C1bPSps4hoyY7uwypR/2MCkXZQsYmvLCG1gak2hDIwE+aYlOmb65tNwab7XuEAeYTScQbX7PTUpkMeot8onXsCe+PSesx+xTWFKBT6C0t8hX5UEweDTly7vBkIjShuUQMC2jfeEhmREz6I3qUUnxdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jxAOkBtN5Z0P8T9EA9K030+P7bgNO5npwwWiZCLvH/8=;
 b=L7U4U+566MY2T+LJRIgID2VCoYmJCjKqlT1OGiL6+zSx99oIap/kPG2fdwf4nUgodDGEN7L7tJWjod1NFfIjfKs60H/ZN4ZRNvij3M4UKnNFALc7x/Vk1NeIs/sy4NnVjF4Id1qEsATwSwIpvrOb/JN59GLAmWnwuPM6UfK4XStuinoLyFbWGK+gZUGneO0IL/9Ei1yGb95hok9LIOX1HlsycvRqxvh9+DwkFcENJbi9aE+Z9MHcc79IGkKHUMLHIy44CdApf+PmZrdJzwGenkPMj3pZvQ97tjQMUhiKmTWET4thiIphR8qNi32S/nH05nsQetH8uc0vg3vsm3NVYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jxAOkBtN5Z0P8T9EA9K030+P7bgNO5npwwWiZCLvH/8=;
 b=LbZ93m2ZAyc4/VNggLaBpL8qViMOqf0cQ/OIPzIVP8eY3fidvciFWJLwo1tPB7qglGIRVWDdPnfkKn/AtMhibQ2gEC0Gp1BJBB2c6ML+Qm3NH8DlClU0gTStQTR7cCj5hfQMrD5l5icAGOMlqFBl3Fv3eTGvdnNDpckZa1zPQh4=
Received: from BY5PR21MB1506.namprd21.prod.outlook.com (2603:10b6:a03:23d::12)
 by BYAPR21MB1368.namprd21.prod.outlook.com (2603:10b6:a03:112::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.5; Fri, 4 Jun
 2021 08:49:46 +0000
Received: from BY5PR21MB1506.namprd21.prod.outlook.com
 ([fe80::fda7:afbd:5f96:a099]) by BY5PR21MB1506.namprd21.prod.outlook.com
 ([fe80::fda7:afbd:5f96:a099%4]) with mapi id 15.20.4219.013; Fri, 4 Jun 2021
 08:49:46 +0000
From:   Long Li <longli@microsoft.com>
To:     Andrea Parri <parri.andrea@gmail.com>
CC:     Michael Kelley <mikelley@microsoft.com>,
        "longli@linuxonhyperv.com" <longli@linuxonhyperv.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrea Parri <Andrea.Parri@microsoft.com>
Subject: RE: [PATCH] PCI: hv: Move completion variable from stack to heap in
 hv_compose_msi_msg()
Thread-Topic: [PATCH] PCI: hv: Move completion variable from stack to heap in
 hv_compose_msi_msg()
Thread-Index: AQHXRwXUcSr7TOzxAkmxOED9A1jUh6r2K36AgAlpMCCAAFTJgIADxXew
Date:   Fri, 4 Jun 2021 08:49:46 +0000
Message-ID: <BY5PR21MB15061364D7D48499F5D7E8A0CE3B9@BY5PR21MB1506.namprd21.prod.outlook.com>
References: <1620806824-31151-1-git-send-email-longli@linuxonhyperv.com>
 <MWHPR21MB15931F1698FD128C76219F7DD7249@MWHPR21MB1593.namprd21.prod.outlook.com>
 <BY5PR21MB150673A34B431F9311E6FDC5CE3E9@BY5PR21MB1506.namprd21.prod.outlook.com>
 <20210601231339.GA1391@anparri>
In-Reply-To: <20210601231339.GA1391@anparri>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=30cdc0d9-fa97-41a9-8df7-63f7bf545e00;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2021-06-04T08:49:11Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=microsoft.com;
x-originating-ip: [76.22.9.184]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 658e44e4-f435-47a6-dbfe-08d92735b4a3
x-ms-traffictypediagnostic: BYAPR21MB1368:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR21MB136800884C25B8D8020605E6CE3B9@BYAPR21MB1368.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ncxx+QFnbToPFcKkiQg+mEmii9o943YAOEc6kGkT82jAVWIpf5heg7LvcXNOnnDnQwagSghE02CUR7r6UeE+jMOKPfv/rElySGszTwVmA+zYAy3zr80Mejjtr1TQbiRNi8+MhZtz40A3PqHSSDwjczb1kxtXoA6hVo3QwCjB9hXkNFNIhZUHDh7VRxUt1VW1tZWfV6gMqLjw9L0dP1Zp96dPyAl7eOOLcDXTYnqjcEjCzR6WGm2J1+wWMqRuwQ/JCP/XYz8ggocNPr4oFs2s9t6c0o46XtcuF0R4fGZu8GID3M7BoJXALjbAcDAYSl6gKaEgMNkOBqcmx7XrmQ2iP+zy8xicEtb6V3HXC1M/iEJ/FxD3h7ghtPRrvUj1BBskmZiclQwMfsfUvpQAROifPpGwtPy5IMpVxlcAfHgYsR113wQxJc3SZrmeexr7zTLdOzPFZYDyTyEvCjGNK41snwzHIlDJLyNxDL8STNKTdCa6GTO1yChsaTmr1rCaBg84xbXD7UihvfAiFLHhzv04Rw5BpjPltCjqcfMkaIjDtJQ5CGO5sFCG9DBc8uypPHsDN5jI6OPpwHTYl6//+5oilxajGs4T7Owobw2BBaWLApf1KFujkBlse56B90LQJslbIT77Kl7nxrkGFuF/jZpq0w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR21MB1506.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(86362001)(76116006)(6916009)(8676002)(54906003)(9686003)(186003)(33656002)(83380400001)(107886003)(4326008)(8936002)(26005)(8990500004)(122000001)(38100700002)(316002)(55016002)(478600001)(6506007)(82950400001)(10290500003)(82960400001)(71200400001)(2906002)(52536014)(66476007)(7696005)(66556008)(66446008)(64756008)(66946007)(5660300002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?JZC1gupexfK4otp/M5/3jiEnsBuB64di12gDJbftsEgZHqxqo1A60TrVVC8u?=
 =?us-ascii?Q?92SsR+xKks5+xodLftSXsrnWL1pcXLwvjofVMh3N0vWyCkf3nWD9jico2w0L?=
 =?us-ascii?Q?kMkqcleyfMHoET1/2cwNvHDKHMIiX0IbwpzNKpXVZXeNc6rTWjqXFVgcqN6F?=
 =?us-ascii?Q?yHnCweM8Eafcyf7slHbb73Yp5Cj+hIPBM9KWpYUAvWbh/217IDGuTWR7mBSm?=
 =?us-ascii?Q?hjbZ7TS3DUFItyOgwO6gEc5ETZDvw2iSg789SupXbbqwSD2mOE9juDb2OwTe?=
 =?us-ascii?Q?rWQwYVKX1kwt3KmJBmCl4XOjo6HziAlJK3q8SqFUyvxt4RHGUKtgoEzpXxna?=
 =?us-ascii?Q?cyrgc0Dzb+7FO9sr7nZ1HKLP7nDI6PmIzvk2dqL3O2efQLci2I4JhqlnUmXH?=
 =?us-ascii?Q?uvzjf95aXQ1oSK/LkSBKPZTRnX2CeY2jS4J4LCyGvdU0wFR7ow5rgTGdMLBn?=
 =?us-ascii?Q?ssrhXNejLOGNiVY8v7lk7VYsobybsCXpLiQlm5UIKIWo7Z+xvz0pNg/vjJ6O?=
 =?us-ascii?Q?vUFrtBkr+/jttKMJdm1fKJrDz7yIzHrca9mKQfb1AjfhG+vjswUSUrqNNT4I?=
 =?us-ascii?Q?4vizeS8KXrAwBn/4N5mZ9vlkikDjx/okMkEvaG/ewEVwO7xY2bKpUpdV1X9F?=
 =?us-ascii?Q?Nbm8HmROnDVKvtWBJqw4hi0FE8+Howiwv+a11TXcwHAQf+Eu4w1QNceC25Rn?=
 =?us-ascii?Q?R7dLz3Skby6ZGYEPd/W3TB6wGGeFJZHmogeyJ27uFzPSAksxYLb1c874quyo?=
 =?us-ascii?Q?7tu2NKyr0T46zuByMp9i+n/NCEPSSBliU8s/EedXbkFbHfEaKh4+5u0iSD4i?=
 =?us-ascii?Q?ceBRzVuvtCibkJDRC8JXahq9xJN8N27YiI/lOjTprIRRb/GgRfdxTfZ4K13T?=
 =?us-ascii?Q?4DGKiG08gIuairpjC6TgGRQzUgoKmVN+vISFLCKlfz1Oyg3NkIKKHVU5KDYP?=
 =?us-ascii?Q?TwWD64FfJdETYGYQVswguPNtr1Sz3ruFb7IKKmxnXhHDj6g3dySJ6RJkAAAb?=
 =?us-ascii?Q?0Ejq6Eq+QMT3JJP2TgPUmrh7Hm2DiTMEJRHaPiy56ZDJXwiqWM39wThTe5vY?=
 =?us-ascii?Q?oCdaXsQ3Z1YtYTZGAMtkC/rekS91e+mC+twAKd2ddDxydfYqy7XRR1gQcCeq?=
 =?us-ascii?Q?ryeiKMrzM/jNYa9igrdbnb3vqJQO+qIMXo9XzrQjGDk9c/JtYE8erooXDFTq?=
 =?us-ascii?Q?3qDxlqGdlltIJ2BjINSlLUspVLlX28HBBdWbCuhfXgzv1hIQy0HHG54J37eg?=
 =?us-ascii?Q?5/53Pjy5LrOw/PPtSIGDvrTauFTdJwu2TOeXs5cGm2sYZ3mZa3z2Is05WqE1?=
 =?us-ascii?Q?JLI=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR21MB1506.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 658e44e4-f435-47a6-dbfe-08d92735b4a3
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jun 2021 08:49:46.4862
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OvY8Bzz9RZWYsCl0JrVf1jwtb7/5C8roU88+Ezx8Z9y4UHWK7SGzwmxGrnGmP4xTejCmL/u7yn2x7ivP/aFjSw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR21MB1368
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

> Subject: Re: [PATCH] PCI: hv: Move completion variable from stack to heap=
 in
> hv_compose_msi_msg()
>=20
> > I agree if the intent is to deal with a untrusted host, I can follow th=
e same
> principle to add this support to all requests to VSP. But this is a diffe=
rent
> problem to what this patch intends to address. I can see they may share t=
he
> same design principle and common code. My question on a untrusted host is=
:
> If a host is untrusted and is misbehaving on purpose, what's the point of
> keep the VM running and not crashing the PCI driver?
>=20
> I think the principle can be summarized with "keep the VM _running, if yo=
u
> can handle the misbehaviour (possibly, warning on "something
> wrong/unexpected just happened"); crash, otherwise".
>=20
> Of course, this is just a principle: the exact meaning of that 'handle' s=
hould be
> leverage case by case (which I admittedly haven't here); I'm thinking, e.=
g., at
> corresponding complexity/performance impacts and risks of 'mis-
> assessments'.
>=20
> Thanks,
>   Andrea

I will follow Michael's suggestion and send v2.

Long
