Return-Path: <linux-hyperv+bounces-458-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 959E77B6FC5
	for <lists+linux-hyperv@lfdr.de>; Tue,  3 Oct 2023 19:32:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by am.mirrors.kernel.org (Postfix) with ESMTP id 07FDB1F21076
	for <lists+linux-hyperv@lfdr.de>; Tue,  3 Oct 2023 17:32:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE4DB3B2A7;
	Tue,  3 Oct 2023 17:32:38 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F0F63AC15;
	Tue,  3 Oct 2023 17:32:36 +0000 (UTC)
Received: from DM6FTOPR00CU001.outbound.protection.outlook.com (mail-centralusazon11020025.outbound.protection.outlook.com [52.101.61.25])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDA3CA6;
	Tue,  3 Oct 2023 10:32:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ngB3uiEGwo27oDjdQcWg0zHVSoMZ4ZjAAelXV7t1kK09rmFHV60v7XB4F+8tcPErm+McMEEwjA2Ivzv1h1UHcZM8rhOgDOcFATbPlkG7xVJ/7XEfqWy7Gg0kNh4X1Gw4tOu6YF9uIaUXl9dRqWi01N1h9W50BCPXZDbxFgfHyvbEVItH0PO07LwyN+iEY7C3myKooD4rD+VUJ5TXM7P+GOQc5EQjJU1MFLqTMiNnaBG0xvGounV+aqqgohSUEEzlLr3rfsrPh1Ysj+oSGYMRnsu67BHc3nlNJ9Ujy+Ltgi40DVhLKi/1pdPzTHNNlESCi/nkhARr8cpV+ryRVM0IBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xH7H+NHggh02MQewjwgSWoWVl0RjRftTCZRkNtYlISE=;
 b=hOsUJVExX3/PmNFvi/pZDnOQrFde/ani3IREDsWesO+03L+NDEc5KJStJ8ohD9fvvwjV2zXBgfP9Rqn+vNEsVbSqVIgvbSFGqIQXPgbbLVVq3Qoj800bn+m7WwxiNPUhDiXZaFreQNy7lYMJAkbuYhJy4OVBoA1tvUoHD+QNBJX3RnnP4qjMXb3pK4Q3g+TT8fZ3OaAWDWZqhCN7UhrXdbU9dkAHsx8AmPp+QeWkWg3HJpaFDKCU+koi6PRgQkrbjeOlNuq1irbTILHLvSYEPkJPkxXj11OeBuCkl5fM/SjEBavFr9Ak+RklZ7H5Aj9DmXD9NjxmmLFNPcNY0ueS1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xH7H+NHggh02MQewjwgSWoWVl0RjRftTCZRkNtYlISE=;
 b=d7nbPczr/a5Ix/H7nId2MzZe8ZOLUKUGOdDLKJxqLrfYM3EvbGHiafY2h74m4RgSQiBggsHbmf888lua+oRGPYgLnyapMpFCLzoir1cslcpcy115BAdBNt3g5+w2qwF8UrKn8oKu2bYnvtVvC7s9MgAzSByZjNrPPTGvZOZZ9w8=
Received: from BYAPR21MB1688.namprd21.prod.outlook.com (2603:10b6:a02:bf::26)
 by SN7PR21MB3952.namprd21.prod.outlook.com (2603:10b6:806:2ee::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.1; Tue, 3 Oct
 2023 17:32:29 +0000
Received: from BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::ef:cf62:9355:5884]) by BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::ef:cf62:9355:5884%3]) with mapi id 15.20.6886.004; Tue, 3 Oct 2023
 17:32:29 +0000
From: "Michael Kelley (LINUX)" <mikelley@microsoft.com>
To: Sonia Sharma <sosha@linux.microsoft.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
CC: "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, Sonia Sharma
	<Sonia.Sharma@microsoft.com>, KY Srinivasan <kys@microsoft.com>, Haiyang
 Zhang <haiyangz@microsoft.com>, "wei.liu@kernel.org" <wei.liu@kernel.org>,
	Dexuan Cui <decui@microsoft.com>, Long Li <longli@microsoft.com>,
	"davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com"
	<edumazet@google.com>, "kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>
Subject: RE: [PATCH net-next v6] net: hv_netvsc: fix netvsc_send_completion to
 avoid multiple message length checks
Thread-Topic: [PATCH net-next v6] net: hv_netvsc: fix netvsc_send_completion
 to avoid multiple message length checks
Thread-Index: AQHZ8YhOXvETm+RteUGb5w6Pv8B03bA4WOFQ
Date: Tue, 3 Oct 2023 17:32:29 +0000
Message-ID:
 <BYAPR21MB16888B05378FB084DFA904D4D7C4A@BYAPR21MB1688.namprd21.prod.outlook.com>
References: <1695849556-20746-1-git-send-email-sosha@linux.microsoft.com>
In-Reply-To: <1695849556-20746-1-git-send-email-sosha@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=68b68c76-a406-4d2b-b50f-0747107e90b4;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-10-03T17:20:57Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR21MB1688:EE_|SN7PR21MB3952:EE_
x-ms-office365-filtering-correlation-id: 39358ab8-efda-4c8f-b1ed-08dbc436b7b6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 KCNtGFFOCVcdOj3TrCSfnRC0nBFva6hWvwZBVoGSC0da37FURLTbPBZwK0fNOV0OIzm56Di9nhnorYV5aynXUU4coDfOoZU6rXd8ALVdCeFivz4oGM5dgjejxCvVWc+FK39DFmRjTLsHQON9+VJTGnJm4w0CDhSlDzRx/QoPVjr34EArHVk+g3UZe2s5ufUKdwlynCJ1trPWNjxFwomz38fyoyMsznl6VyaWSWISf/MtzTjhtiNbiRfM0ivu+28hn0ygzGcAAYcp+fPh266TbQbPVE1pW1xFFM/zDD5y96sL4cQ9tiHN9TGp0wkHkhg8cEE6pZLjebDwJq1DocmQcZ9TRt2FikILv5PBC4dGct/oRYcyv2vloWN5eGcQcByQyhRRD+ok3ZyN6au2f5sNDtkpMR/jNFWtB79JZxSmSiiphn+Bv7NhzrlsjV5LbRje6dYgrhhCtmYsxNbyiLyMGvm4izPDgyzZWCY//GG/fcp43/uk/QnVI3dJBLL/QmEVWYQ32rQ7gSc4SUXsv1Fz5OkW7UWKM7414B63brxVqfq1vjAtnuZeAvauONg+9VaP9YllT63HjPVX8xVY/2w20xCFg2PW9ExY6fqaNJ+SIXXkRmb47AGcFz/ImkgVycqHLcAiTO3Ucnz6/HejmmptgNLEGNdloroT+r7lEUATD1Q=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR21MB1688.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(39860400002)(346002)(136003)(396003)(230922051799003)(451199024)(1800799009)(64100799003)(186009)(82960400001)(86362001)(8990500004)(8936002)(4326008)(8676002)(38100700002)(41300700001)(82950400001)(38070700005)(5660300002)(9686003)(52536014)(122000001)(71200400001)(33656002)(6506007)(7696005)(64756008)(15650500001)(54906003)(478600001)(2906002)(10290500003)(83380400001)(26005)(76116006)(66946007)(55016003)(66476007)(66446008)(66556008)(316002)(110136005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?g3VEau1AilKny7DSzCUEqKLzGdNi+bcYALSivp2VeGAbr24mPzgPRltC3RYP?=
 =?us-ascii?Q?JQataGRWmVpbTbSEDIMvBqzxhU+tXZovWYd96bwJbYgRwBvCvFf71y/KZ2/x?=
 =?us-ascii?Q?unxJwBbHosjcQXRK8SHpUMDkBsA/mg1ToHuTY9P92/37H/37GaSO1v9CKkSm?=
 =?us-ascii?Q?ZKmwVdwvw9CvO5/nTMA3jL+2yHtCzr+1w9UR8IEPiQIijrpL7p+4Ko7FrXSK?=
 =?us-ascii?Q?YuEJ1WzuV1QrK2JeZYihChwt39dxpFYT/7KNRBVpVmIlFbbrTJ2T61AEI8eE?=
 =?us-ascii?Q?9ze87LMZITPqv3NPSKMrXALhtnKE0/ANiQliREJIyEtoCf0Feq76H+7cgVQG?=
 =?us-ascii?Q?1O1QKi5WOQQ9otI8hHcCzPRrrkhav6jEcg7swOljOKxMPLMx4etJ3w/g+IaC?=
 =?us-ascii?Q?BiHCshM386QQ5mJ/SQ2NLkoAwtzJM7ACxFKwsCDU682ojIUhBVYtaDOvw9L5?=
 =?us-ascii?Q?gLv121g1M9rMiQdtK4q/UdtIAZvpRCPcsXrXUc4KEufJTl05Y4omPISsH4YB?=
 =?us-ascii?Q?bIL3hBifmMwZnGz2TZRLYf231CJFJ80jZZhrwxP3bWqqq+DY23JqUouHsV7q?=
 =?us-ascii?Q?f9ecalSY+hXLUz6hHNNOqqSmDxADGt29Zw5XYn7iPCotokeI7gRNq6Ph1nEy?=
 =?us-ascii?Q?/wHgwQPyrK093rIWdEEMoAaB3u4QhjXdg/1N1bmKNbTnGFvaPrnafXbfqAFJ?=
 =?us-ascii?Q?F3ib70OXMXLdZ9BbujnssUaDu7njMnBPdLgI6+yzuUarhlx7GiDGcbTeEVAA?=
 =?us-ascii?Q?sHOuJdpaNtS00vz/EnYjxfbfsQcUo9+mBRnsIvxeCGCNBKAGuc3E7dcHJ2nm?=
 =?us-ascii?Q?rTeunP5U7GUgd6G4m95n8UdLJ+P3YkhlmmFmnTL3gYuEOnKczto0xzd/LdiS?=
 =?us-ascii?Q?6Kd8Q/0yPnd1+4I89cHFy90IzStiDWxSB4ukxnOsU0UvqSJUxoKXakSrgOr7?=
 =?us-ascii?Q?D33Sjf3/HJudo/h2fp2J7faQR/FR97Qz0nEvAYsHUe1dVZTcrxXbkaktdIpL?=
 =?us-ascii?Q?970rEPX6qNl8lokmb7t7jeq/7/6EoZENr48Qwh6F981VYtP6yB+yAS1vmciF?=
 =?us-ascii?Q?gh93HwFAw6IaiFmD/ov2Ef2boqF9B3p17mGjHAwYVik3xsf14HQ2gdmZ9GeS?=
 =?us-ascii?Q?cWykfsW1gShc1z9K3ZOCfiyCwHO+99jDSb6J9SkMx8pWl4HPukoCH7SYPWRj?=
 =?us-ascii?Q?psfxKGqgXzKL3nfQr6YPzqB6Z3pcLgcEZxeKg+RlC8dULVqHCHRWWilmgW11?=
 =?us-ascii?Q?0K6In7Wu44o2NoNRBcQ5DZCUx5KaLG8o+9d4q2ZVEe8BTonxDEewB0bRJa6+?=
 =?us-ascii?Q?E+T1+KCurrzisnlN2cY/mk/v8nHbGel5554NPHuzLH910wMhZHsQ/oDucl25?=
 =?us-ascii?Q?UZnQRC/O5AeUndMfwNZHApF9ILaPqcJOVVoTEnpPTIDQfK2zICds5A0E76PN?=
 =?us-ascii?Q?O8qx0amXMfczsSLxDPpiEEA5B7AZqgVoiM64EzKxQyxY7mGFYqiTvtEX3Fc2?=
 =?us-ascii?Q?u+W7CvepCD1gYsxJcwPSC/LEkfzP2spf948c6LOoARKXrkaz07yYJyVIaFNK?=
 =?us-ascii?Q?l6pM2QLGx6SBCGiHMmP1tLIrLcfJi1WHtUPu/K6U7BUmNMLuCJJg2Mm9vhil?=
 =?us-ascii?Q?BQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR21MB1688.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39358ab8-efda-4c8f-b1ed-08dbc436b7b6
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Oct 2023 17:32:29.2339
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /uADCVVKrE05Xqc2xB9y2h9GxP64UV4zeoLG30ejsWRVEme5nOwT6AFRhzyRHQM4HGnJkwM1c+RgJIWUjNk5FKGbGARxZTE1X30EndTD5yE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR21MB3952
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
	autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Sonia Sharma <sosha@linux.microsoft.com> Sent: Wednesday, September 2=
7, 2023 2:19 PM
>=20

Patches to the Hyper-V netvsc driver usually have the patch subject prefix
as only "hv_netvsc: ".   Look at the commit log for the files in drivers/ne=
t/hyperv.
There's value in consistency unless someone really thinks we need the "net:=
"
prefix as well.

> The switch statement in netvsc_send_completion() is incorrectly validatin=
g
> the length of incoming network packets by falling through to the next cas=
e.
> Avoid the fallthrough. Instead break after a case match and then process
> the complete() call.
> The current code has not caused any known failures. But nonetheless, the
> code should be corrected as a different ordering of the switch cases migh=
t
> cause a length check to fail when it should not.
>=20
> Signed-off-by: Sonia Sharma <sonia.sharma@linux.microsoft.com>
>=20
> ---
> Changes in v3:
> * added return statement in default case as pointed by Michael Kelley.
> Changes in v4:
> * added fixes tag
> * modified commit message to explain the issue fixed by patch.
> Changes in v5:
> * Dropped fixes tag as suggested by Simon Horman.
> * fixed indentation

Is there anything different in this v6 versus the previous v5?  I received
v5 twice -- on 9/26 @ 10:50pm and then on 9/27 @ 2:17pm just a
couple of minutes before this v6.  Maybe the second v5 was intended
to be v6?   Is the difference another indentation change?

In any case, the code looks good,

Reviewed-by: Michael Kelley <mikelley@microsoft.com>

> ---
>  drivers/net/hyperv/netvsc.c | 18 ++++++++++--------
>  1 file changed, 10 insertions(+), 8 deletions(-)
>=20
> diff --git a/drivers/net/hyperv/netvsc.c b/drivers/net/hyperv/netvsc.c
> index 82e9796c8f5e..0f7e4d377776 100644
> --- a/drivers/net/hyperv/netvsc.c
> +++ b/drivers/net/hyperv/netvsc.c
> @@ -851,7 +851,7 @@ static void netvsc_send_completion(struct net_device =
*ndev,
>  				   msglen);
>  			return;
>  		}
> -		fallthrough;
> +		break;
>=20
>  	case NVSP_MSG1_TYPE_SEND_RECV_BUF_COMPLETE:
>  		if (msglen < sizeof(struct nvsp_message_header) +
> @@ -860,7 +860,7 @@ static void netvsc_send_completion(struct net_device =
*ndev,
>  				   msglen);
>  			return;
>  		}
> -		fallthrough;
> +		break;
>=20
>  	case NVSP_MSG1_TYPE_SEND_SEND_BUF_COMPLETE:
>  		if (msglen < sizeof(struct nvsp_message_header) +
> @@ -869,7 +869,7 @@ static void netvsc_send_completion(struct net_device =
*ndev,
>  				   msglen);
>  			return;
>  		}
> -		fallthrough;
> +		break;
>=20
>  	case NVSP_MSG5_TYPE_SUBCHANNEL:
>  		if (msglen < sizeof(struct nvsp_message_header) +
> @@ -878,10 +878,6 @@ static void netvsc_send_completion(struct net_device=
 *ndev,
>  				   msglen);
>  			return;
>  		}
> -		/* Copy the response back */
> -		memcpy(&net_device->channel_init_pkt, nvsp_packet,
> -		       sizeof(struct nvsp_message));
> -		complete(&net_device->channel_init_wait);
>  		break;
>=20
>  	case NVSP_MSG1_TYPE_SEND_RNDIS_PKT_COMPLETE:
> @@ -904,13 +900,19 @@ static void netvsc_send_completion(struct net_devic=
e
> *ndev,
>=20
>  		netvsc_send_tx_complete(ndev, net_device, incoming_channel,
>  					desc, budget);
> -		break;
> +		return;
>=20
>  	default:
>  		netdev_err(ndev,
>  			   "Unknown send completion type %d received!!\n",
>  			   nvsp_packet->hdr.msg_type);
> +		return;
>  	}
> +
> +	/* Copy the response back */
> +	memcpy(&net_device->channel_init_pkt, nvsp_packet,
> +	       sizeof(struct nvsp_message));
> +	complete(&net_device->channel_init_wait);
>  }
>=20
>  static u32 netvsc_get_next_send_section(struct netvsc_device *net_device=
)
> --
> 2.25.1

