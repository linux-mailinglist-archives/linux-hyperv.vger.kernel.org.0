Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0DF23F406C
	for <lists+linux-hyperv@lfdr.de>; Sun, 22 Aug 2021 18:25:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230323AbhHVQ0E (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Sun, 22 Aug 2021 12:26:04 -0400
Received: from mail-db8eur05on2125.outbound.protection.outlook.com ([40.107.20.125]:32602
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229460AbhHVQ0E (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Sun, 22 Aug 2021 12:26:04 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Dbnk8r/pIoBf/BFzCOBUVXB0ds7nVMv5h2P+TCMCXD3rWUPKvhAeoJBZo9Y0ukDZrPJRk/IYGQVIo6E89bUzpQHUvPg5TJkVnTeUswwoPYyuA7ebKGS6t+O1djwj2uSLbXYPQwCCo4NKaxl2sH/yFcwlhWZGaQL52t+Pw+0nDGa50Cm6ICv0o9eBllT6a/M9wHVL6OnMjp9YCPbjhtfAf/LfrK3RL4zNeMIWYhc9YXT8FrmdEA/TUB8DGFTaqAr3F/fjNqvkC1Pf8UNwYZateRnSju0Wa6I1Mke6Jk4MSahKW8gWH3URam5DLwiSy27Fj99IRkEiiBLPzYu87yV4gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=shYP+MJ4rqObS47dODo0OGMZJvqMnTa/hMusQB8bTok=;
 b=NAl4ggk47wd7/xrVaRX2OEtQfEeyNBdulcWLztFcaBFDw7A7jjy6BRFQq53Py3QpjZi4s+XyILEMEWm9IHZn4BpNuNyeUiZbtM3ENS8M+cHb5VkB932z5jMjbL8rZK4z1gSdEC2M+LAZUXYi20mE3eEzsLpzrP+iHZmrCWBZhFREwqGIN0DNJeiz+/5frdkougnoFjLbldlpGOhtLlHou5UTB4wDEgUBxuu9rGvVS5q7r8bs3lgeXmR8WsW/xAS0pGlo1SeU3hsXCLgxin4WauEvcUH93GePe3IENj5W7szDafi4/zTAyhcWsj17bCDje8srlQKDYthz1Q9ivfHzDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=silk.us; dmarc=pass action=none header.from=silk.us; dkim=pass
 header.d=silk.us; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=KAMINARIO.onmicrosoft.com; s=selector2-KAMINARIO-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=shYP+MJ4rqObS47dODo0OGMZJvqMnTa/hMusQB8bTok=;
 b=n7bzFrrD2iVsNKsAx68BkhKKpfZqm6GY5iwOs511UM+P2Bnv4TL3k5xXLUeafl8NEMlRR1A4yBrvyh7NVbX3OPssyIAH7CuAwqXKnRsx7H3qk20bjbyKlf/CWP5IPuux98mz6r3yPxJriZt5fgamBFwuzMd4Q8hqbIzCCYzZBX4=
Received: from VI1PR0401MB2415.eurprd04.prod.outlook.com
 (2603:10a6:800:2b::12) by VI1PR04MB5407.eurprd04.prod.outlook.com
 (2603:10a6:803:d3::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.22; Sun, 22 Aug
 2021 16:25:19 +0000
Received: from VI1PR0401MB2415.eurprd04.prod.outlook.com
 ([fe80::dd8e:4155:4fa4:605f]) by VI1PR0401MB2415.eurprd04.prod.outlook.com
 ([fe80::dd8e:4155:4fa4:605f%11]) with mapi id 15.20.4436.024; Sun, 22 Aug
 2021 16:25:19 +0000
From:   David Mozes <david.mozes@silk.us>
To:     Wei Liu <wei.liu@kernel.org>
CC:     David Moses <mosesster@gmail.com>,
        Michael Kelley <mikelley@microsoft.com>,
        =?windows-1255?B?+uXu+CDg4eXo4eXs?= <tomer432100@gmail.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] x86/hyper-v: guard against cpu mask changes in
 hyperv_flush_tlb_others()
Thread-Topic: [PATCH] x86/hyper-v: guard against cpu mask changes in
 hyperv_flush_tlb_others()
Thread-Index: AQHXiqRBXwjgsSgsKkyKw+PnE9iSIKtmSmoAgABuwJCAAAw8gIAAP8SAgAB3w4CAD/sBMIAAKS8AgAApdACAArr58IAFOM4AgAAOnZA=
Date:   Sun, 22 Aug 2021 16:25:19 +0000
Message-ID: <VI1PR0401MB2415F41E0D6B43411779911AF1C39@VI1PR0401MB2415.eurprd04.prod.outlook.com>
References: <MWHPR21MB15935468547C25294A253E0AD7F39@MWHPR21MB1593.namprd21.prod.outlook.com>
 <FD8265E6-895E-45CF-9AE3-787FAD669FC8@gmail.com>
 <VI1PR0401MB2415E89B6E3D01B446FD1DACF1FE9@VI1PR0401MB2415.eurprd04.prod.outlook.com>
 <20210817112954.ufjd77ujq5nhmmew@liuwe-devbox-debian-v2>
 <CA+qYZY1U04SkyHo7X+rDeE=nUy_X5nxLfShyuLJFzXnFp2A6uw@mail.gmail.com>
 <VI1PR0401MB24153DEC767B0126B1030E07F1C09@VI1PR0401MB2415.eurprd04.prod.outlook.com>
 <20210822152436.mqfwv3xbqfxy33os@liuwe-devbox-debian-v2>
In-Reply-To: <20210822152436.mqfwv3xbqfxy33os@liuwe-devbox-debian-v2>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=silk.us;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a2524fd5-b618-4da6-9a5b-08d965896ec6
x-ms-traffictypediagnostic: VI1PR04MB5407:
x-microsoft-antispam-prvs: <VI1PR04MB54076A2677DFE5D03949A49CF1C39@VI1PR04MB5407.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: PEqzeXF6cCqNrkbhST32jEQ/QP1W60NN833yRGGYTiUuyNgJ4SCp9zVIc59VLW3/DovsLwG8LB4l5cSQZ2X7TIAQnB0s7vwVG7zQdVMU/axpUqQYkE7A2OFVgC2WlzNeWB8v4iJ42Ue6Ndknr8snXhHJFMKPQ4YIQ9ZwRJyKXW28Bk0EV62qLXhDe+iJt2/WdKn3XkX8lACRPdWy7u37I0Vfw0PoEcGZ89y80D0YgU8uAoTT+Iq5lSvr/JbMo1lWRzrnFbCjaYIKE7OyAjy2vFs8C8v9q57PeWVYJsjz5yZIRUU3vCPxTMgQyg+dTXAhbpeVUN4njb2VXkEqd3Ls5lt98nxG1vGjLyKh7G655BIcs8cqvCvzDzBx+C35FqN36ejtP2mo97JK5ZM3SZUUO/mjuo8pMg33w3N0y27qTglHfbsZL5F0VJz9ZZ+/NpQ4vLvaO/1vRA+xd8INa5qxHm9SNjaD56YJM1IvpUl6bgIbe0CNvVMw/TSJ9ErS72dACkGZj5GGJeUdbv/X/EV+qA03JbD1M65gxd78m7k08k+UE7e2JCyxeh5z6fVBQ96Op8oSJdJqCW+OP09BMt9LFbJUni0Sr4Rw98DJP5TlZXyU49UqyQt/vyO3qQ8BPFCl9rGG3eLHhsSzYlzArSPjZD+lUv3um79bTJfSh7EiGsSc4lyjFUkkmpluW/3EjEZ8iuj6WlpUIHgfdLX7KKbNy2teykcPMjL4aEjaBQ85JBk=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0401MB2415.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(376002)(396003)(346002)(366004)(39860400002)(53546011)(6506007)(66556008)(66476007)(8936002)(316002)(86362001)(66446008)(71200400001)(66946007)(64756008)(6916009)(478600001)(44832011)(26005)(76116006)(7696005)(8676002)(186003)(54906003)(9686003)(4326008)(55016002)(38070700005)(33656002)(52536014)(5660300002)(122000001)(38100700002)(83380400001)(2906002)(80162008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?windows-1255?Q?62kaLfQ32SB6dBXNdW2Ic15I+tUWso9Gp/xZ0TTtPzhbp3Frv0jkFPff?=
 =?windows-1255?Q?t8/Dv4s1uxbf3PkiayIkF7gi1Y1bXb7RMpoBVGoFuEPlWfraxEBGt56u?=
 =?windows-1255?Q?EDzYNl2uaAQLT7IrjZvD5HQTUUnES52brTVvrLhgj4Jx2fSUxJ0nUkYO?=
 =?windows-1255?Q?EuVhgEGg9jCfFlrUkmRyL65kk4+SoOI/agn5pXE+/btPANWaqGgvNdt4?=
 =?windows-1255?Q?n8/4X4vKdc0e7v28JM0mBo4DSl7vzcA78NphSUFG+RERaNsLXlwQeVDx?=
 =?windows-1255?Q?1+9tJjN61XTSPRXSdXKoyyhER1gYQ61reBkctGJyazNHN3dYWis8RSsF?=
 =?windows-1255?Q?y2+pPOC2EmOql5SgcewrSLuIL7TC8m+8RVKE5Idgd6L7yt9AlX9oazbj?=
 =?windows-1255?Q?mwEt4OEGavwOA8d03C9Gj0w9YfmaLBgJSQDHN/9SzaKlG2DDp0vdKg26?=
 =?windows-1255?Q?bVZ40Y5E85dOliINwzrSTQwkbM0Qx7cqMvP3dyCeRuLTX8tHclreZcZn?=
 =?windows-1255?Q?ROofswKAkYxe1OTJV7llrfSAA6806kJz97OONMYH1RunAsZ+3rWA6MTO?=
 =?windows-1255?Q?E/rV8OQ4kI8PMw3ASUX1ZQ0ukUxyhLDFeeIj9wA20wvkIEPvEpkJ7A9V?=
 =?windows-1255?Q?/S36uNQcWiwR5fGAEQbDIphLacvQHOkV4V9vwubBcXmKjevEn1T+GEPx?=
 =?windows-1255?Q?DkjB4XUCagf0JbL1SdGrBrVz8sWhUqzLpV3mQ6DiN9C2t1CUpr3srkz5?=
 =?windows-1255?Q?cO0GM2iMDezaQlusCPA5FWHLHtyHBaNWbjzpzbuAzYkQE4p5doshP6/P?=
 =?windows-1255?Q?GsdBpU3/GGh96bbncdpcR4zK7RR4lP+32p2tx0tH00KOSZ3BBhac/e55?=
 =?windows-1255?Q?poEB9c3LDVsTPsufeVdOPSYBjpgDIF63V4J6khdnI92K443egNw98EbW?=
 =?windows-1255?Q?v+rEcLbZe7Ep+UlPkqNZKTGmlOdxu1aCFsJW+z74uC0198qt6pIpePGy?=
 =?windows-1255?Q?k0r1hV9Tn7DUBYRqck62llHcY1K3MdEpX+ZDnDDmLZoawPwoBA5XjDxz?=
 =?windows-1255?Q?qaXvXMvCGa7azJrLaJIcCtfJu+gRIcoxPezdfpBL/Fmw5R4iq7G0obJI?=
 =?windows-1255?Q?wpUFK4kayJEsGmXji0MUuH2gCL6LdwMTGyMVq0BKOK2vzAAGFv3V/TQW?=
 =?windows-1255?Q?UuqHmcR7dXrf6C5TYGoBJDiG+wP9xKyIJBu8B+kp1R8NFAQXR8QwWdMi?=
 =?windows-1255?Q?DNYVLcv1Uu5fjzKzv26iqpFLkWPVBKWcr/XnK3zR8aCD75o+PmlTNXOL?=
 =?windows-1255?Q?lZvZjWVsEtludvyvG22Qzn40zbsQQkSVM1F2yg1PS02u7sEERXrI6ZcD?=
 =?windows-1255?Q?CndBgCnGkFhrbeBRzKg0XvzTtDBAby+uG+w=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="windows-1255"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: silk.us
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0401MB2415.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a2524fd5-b618-4da6-9a5b-08d965896ec6
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Aug 2021 16:25:19.2030
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4a3c5477-cb0e-470b-aba6-13bd9debb76b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vhqADd7SmYWJBvMO4cus07OF+HsW4XcqmTlVxw5I1T8qep/Dh4McuyRAvnsWy3jS20NxnBp6nDi01dSu2rmLgQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5407
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

This is not visible since we need a very high load to reproduce.=20
We have tried a lot but can't achieve the desired load=20
On our kernel with less load, it is not reproducible as well.

-----Original Message-----
From: Wei Liu <wei.liu@kernel.org>=20
Sent: Sunday, August 22, 2021 6:25 PM
To: David Mozes <david.mozes@silk.us>
Cc: David Moses <mosesster@gmail.com>; Wei Liu <wei.liu@kernel.org>; Michae=
l Kelley <mikelley@microsoft.com>; =FA=E5=EE=F8 =E0=E1=E5=E8=E1=E5=EC <tome=
r432100@gmail.com>; linux-hyperv@vger.kernel.org; linux-kernel@vger.kernel.=
org
Subject: Re: [PATCH] x86/hyper-v: guard against cpu mask changes in hyperv_=
flush_tlb_others()

On Thu, Aug 19, 2021 at 07:55:06AM +0000, David Mozes wrote:
> Hi Wei ,
> I move the print cpumask to other two places after the treatment on the e=
mpty mask see below
> And I got the folwing:
>=20
>=20
> Aug 19 02:01:51 c-node05 kernel: [25936.562674] Hyper-V: ERROR_HYPERV2: c=
pu_last=3D
> Aug 19 02:01:51 c-node05 kernel: [25936.562686] WARNING: CPU: 11 PID: 564=
32 at arch/x86/include/asm/mshyperv.h:301 hyperv_flush_tlb_others+0x23f/0x7=
b0
>=20
> So we got empty on different place on the code .
> Let me know if you need further information from us.
> How you sagest to handle this situation?
>=20

Please find a way to reproduce this issue with upstream kernels.

Thanks,
Wei.
