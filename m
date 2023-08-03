Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAABD76DDCE
	for <lists+linux-hyperv@lfdr.de>; Thu,  3 Aug 2023 04:04:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229894AbjHCCEi (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 2 Aug 2023 22:04:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjHCCEh (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 2 Aug 2023 22:04:37 -0400
Received: from DM6FTOPR00CU001.outbound.protection.outlook.com (mail-centralusazon11020020.outbound.protection.outlook.com [52.101.61.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56564135;
        Wed,  2 Aug 2023 19:04:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iUV6ylE4UBWEDc29E9h6UsGD678znttrIngj4yqtnOC4bVnxNKsIuff3L14V0bSCAd2Miw1Xjcz1Y2EPp7ylATYrvZGqdYPyFJSjO5iJVc/YVCnjLZ9kD98LAzMu1dcEs0noccBVpFDH1tuuIMgWTPw392vqXe35ad5jKhtAJ27x1UhM24RYbPn/MegXbEVb0z/xMog8qFpEJzDhJNxawJIWknceqAMyMVSlp620LfXSxBXHMNn7FcrXRh9vriFIvKBgWpVBLoC7HR9g3rsJHlMWNK85Y+D6QMFJzhrjiSV7VT+wM7TnX5nxBpidLlsdCBFYqA8FxVUWtOCejAFfsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v3T0iuEvQFJzC/Ou2F9qfJI/DpVByyUPJk76pCs6ruY=;
 b=bVOsPDQI9iqnupxEfnft8xsILByhPFxfAFnTrg2WOjPZ8j6NWGhae+G5zd0iJWM7XPgJ6I+KoeUlVQxCxNjJ2pwXo3mj9IVNzl/nkb45N7UI6ruk8opt98ev7KS11LMqmCScGTDDsuQZykFjaie0/n6t0X/eZDF8KF/d8eGAhQcY+G0gUUlFso9ltZvPCA5iOn6rHQ9QZZW/CkP3k3C44FrKOKrIJVdIRtud9NA8AMV86F2olM55dAOZfQgq6p+YrwDxBFpt2zidezhtgZJOaY3IRbHaaQE6lm00XfpnRQXNwnTarQJKjCQHGNkiMiUqfR2eseDTRHJx9AnLJNODGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v3T0iuEvQFJzC/Ou2F9qfJI/DpVByyUPJk76pCs6ruY=;
 b=LgQEChFq5iIrk40CngcMy6dkMCvGwoz6OteJiDbYhRgI9yqKAmLVhHryd10dxfdcNAL2xte8kLs5m8SdV54+7tmovVz5B7Dp7QXQZgWWpHDs1H4jd6qf1ws8fdAtoQzSO86oG1L6tLc2c1MqsScZUvmto1ErwkPsT1Kmz5TdHR8=
Received: from BYAPR21MB1688.namprd21.prod.outlook.com (2603:10b6:a02:bf::26)
 by IA1PR21MB3570.namprd21.prod.outlook.com (2603:10b6:208:3e1::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.9; Thu, 3 Aug
 2023 02:04:32 +0000
Received: from BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::b588:458f:b0dd:8b9f]) by BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::b588:458f:b0dd:8b9f%3]) with mapi id 15.20.6652.004; Thu, 3 Aug 2023
 02:04:32 +0000
From:   "Michael Kelley (LINUX)" <mikelley@microsoft.com>
To:     Sonia Sharma <sosha@linux.microsoft.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        Sonia Sharma <Sonia.Sharma@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        Dexuan Cui <decui@microsoft.com>,
        Long Li <longli@microsoft.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "edumazet@google.com" <edumazet@google.com>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "pabeni@redhat.com" <pabeni@redhat.com>
Subject: RE: [PATCH v3 net] net: hv_netvsc: fix netvsc_send_completion to
 avoid multiple message length checks
Thread-Topic: [PATCH v3 net] net: hv_netvsc: fix netvsc_send_completion to
 avoid multiple message length checks
Thread-Index: AQHZxaPRZePiLq5GI0ufzhY0R8ayaq/X0hig
Date:   Thu, 3 Aug 2023 02:04:31 +0000
Message-ID: <BYAPR21MB168850A2233E9FBD922424BED708A@BYAPR21MB1688.namprd21.prod.outlook.com>
References: <1691023528-5270-1-git-send-email-sosha@linux.microsoft.com>
In-Reply-To: <1691023528-5270-1-git-send-email-sosha@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=5cd824da-9b1f-4d71-b77c-52ea0292332a;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-08-03T02:03:24Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR21MB1688:EE_|IA1PR21MB3570:EE_
x-ms-office365-filtering-correlation-id: 76606d94-41e3-4b0e-5317-08db93c5fa34
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hFvJQh8Ef6Oi53XymNH/9MVh8BbPZ73AJ+d7e6DndO2xos4tbwQCKoADq4C4YRMkFNkXKNLE7a8iTWglY+toOQD6aZbG2F50f6K/1E26WHOXdm89u/g00Wz5XTfOhIBnj/aiYYJeotkufts/+oz0LWYUt7pFxoOiOmS0/n+Hp2W2QI6Hmu0duFVyf4WQQCzrARdMQyCGaaXm9RRzaSzRJUXqvQggRHFebgMSO+WyHJ1VSIjCBlh+pKFrgxJSmGXtFSQZu2kt6kBqmegy6X3A8aL53VbpNueM+6s6ccjUK5lTl7DzBhvPu2MVbFPzPk8ygfD+KV71dQSYjYfKeLG1txq5whyg7mfXd63YSIN0jjq3HSZ7ihb3A2v1RqLQA16YjnavVt3mVVEjS4V5XU2PIystprr2/3sua2zpgKNIvaivF64nTLT7gACBfuXlkONRz2LdxoA7o1ZKdayQD4ZaQrowu5R36TLRypEVG/A/P9THuLoT2Tt3TtUOzr/VfxCQDhfEbYVKi6nBsdJnCNH3DJfXthZKWAcmEgKoU4lEBAUrJiEwe6d2qk4OxBlc03oY/96rrxKPCwTPHGBIGDd5ZUVY9mPDcg8+x+yJAVTWVq12q1w2xhDEbXatZ+crF3tF0OpshKAQkFNpsPQ3u1BAYYLhQllPyNbkz2lQDhCRgYM=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR21MB1688.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(346002)(396003)(39860400002)(136003)(366004)(451199021)(33656002)(478600001)(10290500003)(110136005)(9686003)(7696005)(54906003)(6506007)(186003)(26005)(71200400001)(8990500004)(2906002)(4326008)(786003)(316002)(41300700001)(76116006)(66946007)(66556008)(66476007)(64756008)(66446008)(8936002)(8676002)(5660300002)(52536014)(38100700002)(82960400001)(82950400001)(122000001)(38070700005)(86362001)(83380400001)(55016003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?66nSbfMmc07ELAvUVkG+orVjKu+wl6Zft81fj0svJtkp0OTzi8wOZaw0B1oK?=
 =?us-ascii?Q?urQElaR8Y2oyYla1slQ110cpPhUv2+GN7VUj77dvg+nOXfbVO0OUQe2APwMN?=
 =?us-ascii?Q?/c8gIgl35c/TiU43EZ4cSwjRTB9exWWdM3CqWKv7TnwoZwRohbDwezPuANlA?=
 =?us-ascii?Q?XR7ZtmcATlLsMmv5GR+rJL71bs7Eu1GTx6qslJZwHQHJfTi4WvtfFAFwDSVh?=
 =?us-ascii?Q?/t+tPbEphdpyy7D4PstAyYCQzG6RjLwKx1HHsAefYZSh+ITUMTl4Zjs6y+zs?=
 =?us-ascii?Q?v8ylLqWqx/WyDtKzmVvbqcf74SWLMdB7z/D6MArHWF4QQd4djbZbhNsGAfDw?=
 =?us-ascii?Q?lBuBiZacQx7eeFsa6rnYE7OJCwGcBxSRKdpFFLPN7nWrN7dYGx2iaoTDHw3e?=
 =?us-ascii?Q?khzVNk0klylG7YSdIZykadhTzn0ToMWytiAZOsLRG4KVeslouKXMpuStL3hd?=
 =?us-ascii?Q?AdSODOCJGFkIBlsvuzUZ/SCzfm+X2+v8QcGZeij+gYJr0x2qStqfJf6cHoS2?=
 =?us-ascii?Q?8RhUxUxfKM2yR/bddu568DNlD+/4XE0qKcfRJ6COhi7pkkLGQmvEIqynqD6h?=
 =?us-ascii?Q?ERSQ4TEDEExlfwIVuGPua6ARzC+S9V8KKp1gHKjAYXgD75cp359bZqlEOzFm?=
 =?us-ascii?Q?CoLgyQWVksSu636vS8FEgpxsHIBX0l5Jc/iNnWkThkLi0CVHz5uEg02s1ckR?=
 =?us-ascii?Q?VG+8YYxIpus/T6kjOpIy+HXGgSg1+Az2gpi291k9Rw0e+ciaTJ2weXv25M2b?=
 =?us-ascii?Q?rOND296n7q3ClVvuf4t6qZFsN21OSbEm3zqdfxojXBT6tVPEr2kDx6oswEjQ?=
 =?us-ascii?Q?boq/+hvtvdbzZqKC0qI7KpOvvHJRpZ2MvQ3sFFF5Wah6B0iIQHIf/lRlvzHh?=
 =?us-ascii?Q?5+qrWq4Dg7H0emIxZxYsKfOmOirYsQ8LXRPA+6lKPyP815wjJ3vAzPwxwfOw?=
 =?us-ascii?Q?VbHpP5FSy8QueqwH+Sw0gzEgbXUiBc0R+lPyGBiQMPt/IY2c1LK7gT6MMjtR?=
 =?us-ascii?Q?Bv299Qgwe3qOHb1Cdgc+bIaAXQyNES7IAMhMnOvLGRR1ENxv5gnojrvJSyuC?=
 =?us-ascii?Q?CJiN68rfKpmfrgfwwlAUmZYvxhCXLRZWWKbQoBX7TiNyyMa/8qf6JoXiEupc?=
 =?us-ascii?Q?HzEpkKVHC0HKX7ZGFwtXLRwg3jXs01q+DNrlSV3iSEcv7A2w1G1Qy5H8RjVL?=
 =?us-ascii?Q?w+N1Xk4oUlA1VopLKJCh+B3uAQLF5RAMDrKbNCEF66bRc/NbNGZj30JUJ3GC?=
 =?us-ascii?Q?A80UQ16EPBvmN6jW/QJyh+F1DGbcwmVGboxAuXmdP0wT/FPr9dFULv2A1hfn?=
 =?us-ascii?Q?y6K2RGvYEAFqJxXM/JLNIbZydWV4qxB/eN9B/b35bNIPcPzjW/GLR1mYjAay?=
 =?us-ascii?Q?uWbKjAR9qP+EWZPSKrhjK/jog8z7AY9caMMC5YBxY2wOxDfv1TrehamiJbGn?=
 =?us-ascii?Q?K/+e8k+HSGtirV7H6xZ11yVgVPMwAJHdzATBkrgdkbMQN9kHOeqkoZCSZ9hp?=
 =?us-ascii?Q?XHzmdLW/sI7sUkmQdaZl8ErwdwBbEKCqa1u3eJSSdV0x+cTFEOAyF84gvg8j?=
 =?us-ascii?Q?2hh0B7WK51JwoNECgGLeisr422kcOPHx4kmtqdIuUNlU2yp1fqXocpfcKynm?=
 =?us-ascii?Q?BQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR21MB1688.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 76606d94-41e3-4b0e-5317-08db93c5fa34
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Aug 2023 02:04:31.8553
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8cczYEJ9LQlQL8xWvxIyJ9WUPscqvxuasd2lKZ5ppf1P1MMc2F9eU6KO3ZW2nJMUAixZTJ+C9yRBCiGxgQDk8ToX0O5raKpesASAQZDljk4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR21MB3570
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Sonia Sharma <sosha@linux.microsoft.com> Sent: Wednesday, August 2, 2=
023 5:45 PM
>=20
> The switch statement in netvsc_send_completion() is incorrectly validatin=
g
> the length of incoming network packets by falling through to the next cas=
e.
> Avoid the fallthrough. Instead break after a case match and then process
> the complete() call.
>=20
> Signed-off-by: Sonia Sharma <sonia.sharma@linux.microsoft.com>
> ---
> Changes in v3:
> * added return statement in default case as pointed by Michael Kelley..
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
> +			sizeof(struct nvsp_message));
> +	complete(&net_device->channel_init_wait);
>  }
>=20
>  static u32 netvsc_get_next_send_section(struct netvsc_device *net_device=
)
> --
> 2.25.1

Reviewed-by: Michael Kelley <mikelley@microsoft.com>
