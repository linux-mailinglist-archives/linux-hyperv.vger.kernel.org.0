Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D4EE409AB6
	for <lists+linux-hyperv@lfdr.de>; Mon, 13 Sep 2021 19:35:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239266AbhIMRhE (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 13 Sep 2021 13:37:04 -0400
Received: from mail-oln040093003004.outbound.protection.outlook.com ([40.93.3.4]:42706
        "EHLO na01-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S238180AbhIMRhD (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 13 Sep 2021 13:37:03 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CVkQDbHLsekKTYZr9j4uXSm6TvLr90d77lWxjz+e1fR1A6mz79Hn06Ik107X1jj1E78BW+bVRen90Wt/sZKAhDEZD6PrEwhn+u27GzXHJJ4RdIMOiTgiUj6n59YidgpUTRenfFaTu6C9chvItY5jRwuCfKGdx1VlldbWXDm76+iASHJuB5pBkKpzzB2VpBt1+wN/WIJX40Be3bZrCsXmlZTns7yTwq1iHt+ytuoHVhFJVbgmUfa+T9drJG/fIgLXuaZstvVBw5hLjLzyBjUwLPP1cYm6jyHJQti0rwytRvg0zx3NAkSDXVHlTCmluNTVzTo8s8FAVbGc8b89m6USqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=WsQgLrobLuq2DvJExRLM9dXcOLoGJv8kxF/JK3Ses60=;
 b=h3HFQFIW3FuNhacCSY1xEVSb3FQqquAJGU0bMnjfEXxUgSl2xJYdCPKS1y/aseRvquHDw7Ee6o0+vvEAlo9JXbLTBZ3kijLJZnUglvY6FUxzmjpKAnSyQqpPZ6bnU3A1/o1l3WsKmf/hCeDFyOzTyLzG4slk14qMtZ24WQYtHvQJTvW0r+ffcOx4ZYZ3sDHaoGpYIXQu0sRTBpIL/mdydnlWPzSEYuzSf+//VGb97JgDvMLDb8Gl/Za99REoOc1+482b8yQnfBkEFtMql681OPJrQP+cqgtLsI/O6X36wNeYoXem6iC/FSIMUxO1Rk3Omrs/90QyDXh6F2e21ey41g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WsQgLrobLuq2DvJExRLM9dXcOLoGJv8kxF/JK3Ses60=;
 b=D3vFaA/cBYZvCwE+9HVvqeXwOgfgdjL3PUnE/IKmo4pXF34HVhSXiwBiEgzK9g5NpXz6XwzWzxS14ykP3gTsekWdP51VAZK3IHPqZ7tfiMw6hbZzgee898Jryrw6W7hXf1RXFdmIyxj7GEKnoPJ8BEwVn+aHaeeBFgPDkZm6Teo=
Received: from MW4PR21MB2002.namprd21.prod.outlook.com (2603:10b6:303:68::18)
 by MWHPR21MB0830.namprd21.prod.outlook.com (2603:10b6:300:76::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.8; Mon, 13 Sep
 2021 17:35:45 +0000
Received: from MW4PR21MB2002.namprd21.prod.outlook.com
 ([fe80::b134:7809:fcff:8c8b]) by MW4PR21MB2002.namprd21.prod.outlook.com
 ([fe80::b134:7809:fcff:8c8b%4]) with mapi id 15.20.4523.011; Mon, 13 Sep 2021
 17:35:45 +0000
From:   Sunil Muthuswamy <sunilmut@microsoft.com>
To:     Michael Kelley <mikelley@microsoft.com>,
        Boqun Feng <Boqun.Feng@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Dexuan Cui <decui@microsoft.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        =?iso-8859-2?Q?=22Krzysztof_Wilczy=F1ski=22?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Wei Liu <wei.liu@kernel.org>
CC:     "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH 0/2] PCI: hv: Hyper-V vPCI for ARM64
Thread-Topic: [PATCH 0/2] PCI: hv: Hyper-V vPCI for ARM64
Thread-Index: AdeoxQ5XRzTIpw2mTsOTpj5vPqHxlg==
Date:   Mon, 13 Sep 2021 17:35:45 +0000
Message-ID: <MW4PR21MB20022E3A433CFA1558C71485C0D99@MW4PR21MB2002.namprd21.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7cf2822a-f624-4e5a-863e-08d976dceab4
x-ms-traffictypediagnostic: MWHPR21MB0830:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR21MB08300B632BA4A73784BC3BC9C0D99@MWHPR21MB0830.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8CehtzyB8TguQwLr9NBDMZWxoReltb7EYF0V/HEhVyr1Ni4XNwOEm2tAwORe3DcLp5/H8UPEa7mQyQvw8Y2tQXtDrNwQM1F8eyZWMjuvrIY27sgrZygYs/I9rD/nfbnF+FK02acudu7zJYFagEqcPsk0aNRbz+72r9Bef1dcalPM/JoXqczeluFKsBkzh+VsbDZEpy+xWjY7/j1J+xfq5kkQDord8kmCdBKr4nqieYedCgnLJWo8Dy0hvIFC3d0SJuxNorPjpbWYQ1eO3Zcc4SVd5N+BN+uE6L8xPr330n3MTXa5PAHUFdUnAlJDc4Klf7fFzo3L7jJ7sachK3r4QVfnnJZvM+n7qbxOu1ojJ0ppPBuh46c+t+o5mgN/VVUdMcyR4LcTe5us5eT9OGtbvv3F+n7gavuJ2vNoyMmTNqGU/OMD1fFcM9Q10yIPFCRbevBmax/rCf4M7GAmqZj0YM0KWQOEu5PE+yFwRa95lHgTBAsmW7B+Tlvfj4R2JPoPViVh3Jxh4hHh8WLce06gQozwtrCIjKHrDQzFHiSnuUrEpUaCU+cnvTvloHyJFpUFLbC2RYyYidJbEKnuxHlMQ+oeM5yEclPFDbnN3ywkc6irr9rSdqeb6jnkFDc3wxd3+wTjfv2MvlZK5xS2rtRVT0hCkGW0KWBD9Er6jAUtOdvHgNCBU4gebOVfa+CqCqBh+gpR9asayD8gn2bKl/ZtCp0yzeUsqtTlB/kkLp6gQl0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR21MB2002.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(6506007)(9686003)(508600001)(76116006)(55016002)(52536014)(83380400001)(7696005)(38070700005)(71200400001)(33656002)(66446008)(64756008)(82950400001)(66556008)(66476007)(82960400001)(66946007)(86362001)(38100700002)(186003)(122000001)(921005)(8676002)(8936002)(8990500004)(2906002)(4326008)(316002)(54906003)(110136005)(10290500003)(5660300002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-2?Q?E942Oe3D/NPdsr2M6c2ZjIgqiUQ8GLEsRaMfadY4DjlmXksC+agusBIzuN?=
 =?iso-8859-2?Q?/XW4is8n7kPxCaLf42fR7DlhcSCl6pXkK6KFnFvQkjSEl0IMT1zY4I1q8S?=
 =?iso-8859-2?Q?qaOYLUz/AdzmiG5ceTUcmnqtx79CH7gCFzT8e9BBmAYsM7F3vf2BbZyKq6?=
 =?iso-8859-2?Q?RRCfbw1fJgdH/dORegzuPBi/jeLmCr4EIgprKknPp7oUqAfiutwEQYfLI6?=
 =?iso-8859-2?Q?nV6CiTz9bMGtN/RRPvmVBcul3ckW/eppOSzaRSpC2KLakQncFLhQQym6kB?=
 =?iso-8859-2?Q?MUc6TTlJ4nnt5xIcp0nsC8YagniMLZjmyy+tuV8O67RBgaXC+uWifJUnQH?=
 =?iso-8859-2?Q?vYJCeMrQjwFgQ/gOY8T+6Kca3owM8O5inX0wIGqtFjuIEpgMLenSy8tgh8?=
 =?iso-8859-2?Q?BYAiI86ifo8/GcPWodVR2rgaI+uZj/4poyee9nZDyXmkMj8y1iJt+DqNLJ?=
 =?iso-8859-2?Q?JeAcZP7gYWRfnTN985jwaQtYdV/xgmHGnsC5nX/IfViHZCWOay91yu+zCb?=
 =?iso-8859-2?Q?T7gsQxCg92Of1dFOq6pm5V+wKIFsBmIEZdLe6qpzCcoKLQhY3ZyR48LspV?=
 =?iso-8859-2?Q?UMQK+fkp7sqLOptOXnVxS38LvY7nC0itoPbF+U/KhX4ROwpFfRP4ZAD8CE?=
 =?iso-8859-2?Q?rKNEeA2LCOK42gDi3604I7s4QrfrH8Kds5ZewN67VK3VoM2u2noI4JTK24?=
 =?iso-8859-2?Q?QugPvhJrHFlXT1ssSy5tbQe9YoXh3lntqhSB0MUF6ZwkIRRTCCn6qrie8s?=
 =?iso-8859-2?Q?QWD8jCoFLMRuWRDWw2e/UcnNw264HXc/IpuuYCRnWSJbE/VIKCKcp7xyyQ?=
 =?iso-8859-2?Q?S/HsQdjH3TFJ18ihCbWcXu2oYYL5R98pbb65ghRU62mexC4FWFMNZqZx6I?=
 =?iso-8859-2?Q?jkCtkbO+CMy3ULBM/MnlA5+Go+xgP0cr0vcQZOok3Yg/w7gOMlMwIvFitC?=
 =?iso-8859-2?Q?8hEqD0N2UGzsg0xGo79phAINdt8KYQlnXNLB6ckPXB1HQrde7GhVWZb3sI?=
 =?iso-8859-2?Q?igY2JQC3rw0nb2XuYp+LpAyaUzXOMVGjsxR7XgoLPsJemcpm0qgW+Bbj3Q?=
 =?iso-8859-2?Q?xbl7fBJwzgTdRmwqBaplUr77S6Ksd0K8dHPkos8bdlxBOb2v12bsN8Iwg2?=
 =?iso-8859-2?Q?MluPUKDYk1dNOok6yc5qFcQLByyxW+G12gEMioQi8AXdMVxCKsioeyJyZT?=
 =?iso-8859-2?Q?dOqZE4k2VKanxTwdNiU2mJmFxni1NKHxOh52mt5yYn2iK6VA8RYSD0MUNm?=
 =?iso-8859-2?Q?QE1Y26IA11czTUkvVNM9kJRHf2O8RmCajTDF4hHZFlXGHyTg41oWsNrEuj?=
 =?iso-8859-2?Q?RC6oxPhkGBT3D51XK15y9nE/pExbPyBZQ05+FQEj9QlHaIQUBE6esfWq9k?=
 =?iso-8859-2?Q?6osMQztMo2ZLS2ESV5GS65yf6OFmezXw2/zcT1YzU/HuoCxwfUDWnMaKcc?=
 =?iso-8859-2?Q?fuhe4XW6ZrJHiB+B?=
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW4PR21MB2002.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7cf2822a-f624-4e5a-863e-08d976dceab4
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Sep 2021 17:35:45.1152
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: esySg6zmQMA/vX8D/ByamYfEobB4/abQQvyBpkb8Uh6OTjPfByONJMp/lLiLQuSFK0AY5kbOtzI0ql8a98JyzwHC5s/EAGGEI+lTVhVl250=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR21MB0830
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Current Hyper-V vPCI code only compiles and works for x64. There are
some hardcoded assumptions about the architectural IRQ chip and other
arch defines.

This patch series adds support for Hyper-V vPCI for ARM64 by first
breaking the current hard coded dependency in the vPCI code and
making it arch neutral. That is in the first patch. The second
patch introduces a Hyper-V vPCI MSI IRQ chip for allocating SPI
vectors.

This patch depends on two other independent patch sets. First one
is the patch series from Michael Kelley titled:
"Enable Linux guests on Hyper-V on ARM64"
and the second one is from Boqun Feng titled:
"PCI: hv: Support host bridge probing on ARM64". Neither of these
patches are merged into one branch at the moment. I think its best
to carry this patch with the 'hyperv-next' tree after merging Boqun's
patch series.

Sunil Muthuswamy (2):
  PCI: hv: Make the code arch neutral
  PCI: hv: Support for Hyper-V vPCI for ARM64

 arch/arm64/hyperv/Makefile           |   2 +-
 arch/arm64/hyperv/hv_pci.c           | 275 +++++++++++++++++++++++++++
 arch/arm64/include/asm/hyperv-tlfs.h |   9 +
 arch/arm64/include/asm/mshyperv.h    |  26 +++
 arch/x86/include/asm/hyperv-tlfs.h   |  33 ++++
 arch/x86/include/asm/mshyperv.h      |  25 +++
 drivers/pci/Kconfig                  |   2 +-
 drivers/pci/controller/Kconfig       |   2 +-
 drivers/pci/controller/pci-hyperv.c  |  49 +++--
 include/asm-generic/hyperv-tlfs.h    |  33 ----
 10 files changed, 405 insertions(+), 51 deletions(-)
 create mode 100644 arch/arm64/hyperv/hv_pci.c

--=20
2.25.1
