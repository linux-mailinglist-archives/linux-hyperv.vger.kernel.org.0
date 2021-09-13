Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73505409CC7
	for <lists+linux-hyperv@lfdr.de>; Mon, 13 Sep 2021 21:17:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241691AbhIMTSD (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 13 Sep 2021 15:18:03 -0400
Received: from mail-oln040093003001.outbound.protection.outlook.com ([40.93.3.1]:65387
        "EHLO na01-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S241279AbhIMTSB (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 13 Sep 2021 15:18:01 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WET3TtL54wFjgcykQAvuAOqyllOQoeDt81yy5r1a7G3BLMaTh+rMAkJkVKC75sG+wTawIJefwdF9V0Cevcuo/IZ5tPPLmFxBUCRCTFNsdKr42ck0M/eQNvnPpwAd2VUMMjvZ+RaxBO9ki8IPZcmk9JXscU/gD+LLOn3K08H4iHH3k8GGYzx2niRTrei45F80kqN3k9VXQkLO4pf1cLxv8N9J49KX3AI6sUU4oGBxUOBdJVehnnXjotZ/tbJyrqQ83jOW1VZ9FtfopQvAmRGDGjLG4DcdGb81eLWOaoUwPbaHlDA6NOD69boJ3sRi+iM845/JjnUlxmqlreQJxsEhkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=bQ3RvS2aQN4nDp80tUtUVkIgDLLScePWzhACAybFYqU=;
 b=A2QPLDQ9wh620CUrR0RZsZRqEw25637xO7P093zEQ7JtVyP8G7Z0YIbKCF4z37SAozKcvMrWXq5cQ4zi4Pxe0e4uCwFe8EoTfcEkjYKJtMm0Y2wco/iQV7XPcs3Ss186Pe5zaxecNIG7P6HBjCYm3Rs+u49jgLeYNTJnPDrzgfwkEi6b7zleS6C/2OkNiSgX3Y34gDkEKh3OFjQZfmdsIstdLeYrCwbos3N+sovCtTbgH4VbeI/d6/1VDXZ51Y5pYTt3fMK8KP6MY6HJ4wrAFXjoptajTEyMZ7vZl7J6z0t0u6My+nSYu6nUWrqQAnzRC+lZXhVb3q2FTDUePfw5Yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bQ3RvS2aQN4nDp80tUtUVkIgDLLScePWzhACAybFYqU=;
 b=JhVlXrhjesNc4qmqbNdnbYQbB6Sa6J7dybZf4lM0q7eep9tvpqiY9mwXS8dOdiw71yjdP0ZcXqLrsDZMik9p35U/c4XkcSsm+cdxfsUjMjG5ev146dEebkTcxL6vDQgzisOt4NL2bWRRJSc0QoATrLDxkoxhFeea+F7jynz9lPs=
Received: from MW4PR21MB2002.namprd21.prod.outlook.com (2603:10b6:303:68::18)
 by MW2PR2101MB0972.namprd21.prod.outlook.com (2603:10b6:302:4::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.6; Mon, 13 Sep
 2021 19:16:43 +0000
Received: from MW4PR21MB2002.namprd21.prod.outlook.com
 ([fe80::b134:7809:fcff:8c8b]) by MW4PR21MB2002.namprd21.prod.outlook.com
 ([fe80::b134:7809:fcff:8c8b%4]) with mapi id 15.20.4523.011; Mon, 13 Sep 2021
 19:16:42 +0000
From:   Sunil Muthuswamy <sunilmut@microsoft.com>
To:     Marc Zyngier <maz@kernel.org>
CC:     Michael Kelley <mikelley@microsoft.com>,
        Boqun Feng <Boqun.Feng@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Dexuan Cui <decui@microsoft.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        =?iso-8859-2?Q?=22Krzysztof_Wilczy=F1ski=22?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Wei Liu <wei.liu@kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [EXTERNAL] Re: [PATCH 2/2] PCI: hv: Support for Hyper-V vPCI for
 ARM64
Thread-Topic: [EXTERNAL] Re: [PATCH 2/2] PCI: hv: Support for Hyper-V vPCI for
 ARM64
Thread-Index: AdeoxTZsllWVtNf9RIGrn88zMhJayQADLhwAAABIXAA=
Date:   Mon, 13 Sep 2021 19:16:42 +0000
Message-ID: <MW4PR21MB20020111382C98ADACFF4F36C0D99@MW4PR21MB2002.namprd21.prod.outlook.com>
References: <MW4PR21MB2002654EE498023C6F2E40B5C0D99@MW4PR21MB2002.namprd21.prod.outlook.com>
 <87zgsgb8ob.wl-maz@kernel.org>
In-Reply-To: <87zgsgb8ob.wl-maz@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6aa91127-eb24-4935-61af-08d976eb056b
x-ms-traffictypediagnostic: MW2PR2101MB0972:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MW2PR2101MB09729A1B7F45E7310128CE15C0D99@MW2PR2101MB0972.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3EVUQEGiUWkp/ksKtxxZIOIThjAIjnJElvq0MmihH3gDokzrjMYmq+y2l9kgmkpcGn4hYoObrelXEk9ZfPTp0JsEgMwhD0YuQ0A0zy6XIVK81UvT9QROmUzTo55DoJXiRcXJ+jDGo0gyGUP/I5TG5G2J30somrR1ZQ1kIG/PgSwBPWv9PbloKM2Q+6qIrloALYQNhoB/Pj13cTFbCcniLshL0leSsgKZvpo8A8i44qR77/Z5RoftdjDVT9WMj0pYcuic/KOBhPOMUy/WWu4hmwDS5y5tHwQCpzBNfTMbPcZKos3y+Y1Hl78z4s8cGttbVqr4oriOhbpwmf5ZRBSDuKzydu8WTlhHp0RUwYc7mrWXdguKK8Teg137v3vIW4LoNxABqJPk4R9XGaGWZp/Q/6zlixxNiwKB6pc/ADjCPEqWts2XvYwK2VAsA2zlDXoHILxXvhET5dZ6Pbz8GzDH8mXSvmP55WCNsK5mDCUF8DjnUQehvgYvWL8MSpxxg+Ct37zYfp7VEIA8BPaKn4lTTFexINrBzvecEkcJYzxbePHDPEVLATMI8QvcRfMwAmIg7msXs3TDDNaWYS4hK47j2adcrY483RlF+ziix9zpXey2ATlNcS/cPaPltuoptk5KJV/XAYZwdJxImT9DhmvnIX0C9CNKr0Rd7xcOW30GPFUS/wX077ioy/qmmde/cusrh7eF6Qc+LhPFvMwL/NRUvg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR21MB2002.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(8936002)(38100700002)(4744005)(2906002)(55016002)(71200400001)(33656002)(76116006)(53546011)(66556008)(8990500004)(54906003)(5660300002)(316002)(6916009)(7696005)(10290500003)(38070700005)(86362001)(508600001)(66446008)(82950400001)(8676002)(6506007)(186003)(82960400001)(64756008)(52536014)(66946007)(9686003)(4326008)(122000001)(66476007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-2?Q?tvgAB27Xqin/TIjOhvs7BkOps4rQePJZAnWH2le8kBzfMEkYjxx4zSLcKX?=
 =?iso-8859-2?Q?+YXbEs4mAo5PE6FelK5k3b1rGvDg2Xty1ztOFknGXsHhvPvOrCrz8U/5gi?=
 =?iso-8859-2?Q?sZvd1VutU7xMa8kpZm33fcgSBAfETbglVuQq/xkic+l/Q9fh+jJ/FBoIdh?=
 =?iso-8859-2?Q?CbNc16CNfdFTD7qh7dBi1KCHN+mSv2HVa41WWP4+yw4yPtnT4H8C2t4IXx?=
 =?iso-8859-2?Q?mY2F0mQyGRPG2c/eWXWCNl/7F7aE+6CpzbmpCM7XOxQGvqsgBzN6m90xhb?=
 =?iso-8859-2?Q?RhD0Bri68aUujA0dv6WQu6Ee4PH7c3EGMAKwj2CPY31Y/M8bsLnmeFKb32?=
 =?iso-8859-2?Q?aW7/hT7o+l4PwFcyt0dG7v7LjHWRMXVtHT5wRmLq48v8Hk4w1wqT0jilSf?=
 =?iso-8859-2?Q?oqa0Zmkbuo3az9Knatl81ZYRXa9ayctdBeQk/5Lot36UaML/jYBlAo3Pyi?=
 =?iso-8859-2?Q?emfDrqMjZbtdbx4sQk4gjPlKJNYISSqVogK3C3yJCk7Eg62KH2wRtuOLL6?=
 =?iso-8859-2?Q?IFD8djrIlFQPFHrSCuImTPR0+DWp+P5wJjfb+1a5TbfZlEhdbfmgQorth/?=
 =?iso-8859-2?Q?h9dsZR8Z/VzAy5hTHKpfLdGuz2u7vQC4cIBBDH9/Myhe3Kn8Lf9PkHbgwg?=
 =?iso-8859-2?Q?gtsuGJdCdHSRvwfUDt284uVo+VbYWfQRJdbbMdFl5EWtGh1GCJ0MgOA8QL?=
 =?iso-8859-2?Q?CMyQ3vwVEeawFSVUeim6oLwyiYBOpZUXXdvijuHWzyjgrduD2dZT3Qwvhl?=
 =?iso-8859-2?Q?ZMM7QYIyB3tsa7Yu9fn5K4nxyxyDg9osaDu4Z7zeTLF+rxxL1zHZZQEhTi?=
 =?iso-8859-2?Q?wL6DoO3s1u9dPPRlqoROnk+z+unQWDpENIg8i0bw5EPzXwxo2sOn6mzR1N?=
 =?iso-8859-2?Q?aQaGp6pADZV8TXmVdTqzTvImaqlih8Ol4Y4a/Z4e+feIkXhCL6k8HQBJ/1?=
 =?iso-8859-2?Q?qPpndZjahhd5uq/4dNiM09wfnDRWUmyNukT88whbbfUccJg+uvCykhrlEw?=
 =?iso-8859-2?Q?gIUDan4az6M0OBVuHK+wqT9CZyGSn5zgvUKPJCg92OOJvazDMPT/1+KQHD?=
 =?iso-8859-2?Q?2bEU1RqkcB7mvOr6lD7UB0jCl5hYUw+kiNl1YI6U74GLf2yO3PKAuoh8N5?=
 =?iso-8859-2?Q?KHnxHX/dVuneQSxpOY/v47/kQiFC8okwvZpdfMsbl8+IySZv2dfTUEoiJw?=
 =?iso-8859-2?Q?9TrnjlcSnNl95cUXdTmYCCFg+izWT5onx8NoH35dFl1DHyhiEImBkbARTz?=
 =?iso-8859-2?Q?Un9KPYVRB8wG0cIYRJ5fi3Lomh4cWC3cVGby7uHxPw7FJtgknENJVQ6rD7?=
 =?iso-8859-2?Q?fMGaYGR1T+EwF+gnxSpD4jq7qCaBgxp2TbzdU+CP7ut3Xsr33T/cHtYa5j?=
 =?iso-8859-2?Q?i5Rz9a/TxRhCxoVe4sN8BXO4QkwQ2h/HlAsXCjiAWu4cf/xAac1h/tzFko?=
 =?iso-8859-2?Q?+VvfVeIIE8Mf8mZf?=
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW4PR21MB2002.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6aa91127-eb24-4935-61af-08d976eb056b
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Sep 2021 19:16:42.8617
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: g7mXhI5Xny2eIL96Zx9D7yq2yM0PEWWuK8lyWJlOgLXgxN4ptm8X9K2ogV7CeoF2qe5Q62RLcxALDBqpaYxkr6VJUFFkE+WDwX5NlwaC1kc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB0972
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Monday, September 13, 2021 12:03 PM,
Marc Zyngier <maz@kernel.org> wrote:

> > This patch adds support for Hyper-V vPCI by adding a PCI MSI
> > IRQ domain specific to Hyper-V that is based on SPIs. The IRQ
> > domain parents itself to the arch GIC IRQ domain for basic
> > vector management.
>=20
> Given that we literally spent *weeks* discussing this, I would have
> appreciated if you had Cc'd me directly instead as a basic courtesy
> rather than me spotting it on the list.
>
I agree and please accept my sincere apologies. It was not intentional (
I just grabbed the list from get_maintainers and didn't pay further
attention to it). I definitely appreciated all of your comments and feedbac=
k
on the other discussion.

Thanks for your feedback. I will respond back to you, but I did wanted to
get this one out.

- Sunil
