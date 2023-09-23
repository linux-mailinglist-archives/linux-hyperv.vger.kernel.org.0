Return-Path: <linux-hyperv+bounces-170-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ACE0A7AB7FA
	for <lists+linux-hyperv@lfdr.de>; Fri, 22 Sep 2023 19:43:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by am.mirrors.kernel.org (Postfix) with ESMTP id 170581F23218
	for <lists+linux-hyperv@lfdr.de>; Fri, 22 Sep 2023 17:43:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82087436AE;
	Fri, 22 Sep 2023 17:43:11 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F9B04369C
	for <linux-hyperv@vger.kernel.org>; Fri, 22 Sep 2023 17:43:10 +0000 (UTC)
Received: from omta036.useast.a.cloudfilter.net (omta036.useast.a.cloudfilter.net [44.202.169.35])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D8A1CF
	for <linux-hyperv@vger.kernel.org>; Fri, 22 Sep 2023 10:43:08 -0700 (PDT)
Received: from eig-obgw-5003a.ext.cloudfilter.net ([10.0.29.159])
	by cmsmtp with ESMTP
	id jjIIqYCtbDKaKjkBHqDSxu; Fri, 22 Sep 2023 17:43:07 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
	by cmsmtp with ESMTPS
	id jkBGq4XmHVpk9jkBHqGwzV; Fri, 22 Sep 2023 17:43:07 +0000
X-Authority-Analysis: v=2.4 cv=CLw54DnD c=1 sm=1 tr=0 ts=650dd22b
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=P7XfKmiOJ4/qXqHZrN7ymg==:17
 a=OWjo9vPv0XrRhIrVQ50Ab3nP57M=:19 a=dLZJa+xiwSxG16/P+YVxDGlgEgI=:19
 a=IkcTkHD0fZMA:10 a=zNV7Rl7Rt7sA:10 a=wYkD_t78qR0A:10 a=NEAV23lmAAAA:8
 a=J1Y8HTJGAAAA:8 a=VwQbUJbxAAAA:8 a=1XWaLZrsAAAA:8 a=20KFwNOVAAAA:8
 a=cm27Pg_UAAAA:8 a=YSKGN3ub9cUXa_79IdMA:9 a=QEXdDO2ut3YA:10
 a=y1Q9-5lHfBjTkpIzbSAN:22 a=AjGcO6oz07-iQ99wixmX:22 a=xmb-EsYY8bH0VWELuYED:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=uqrrds5r8x3t4h70fPgAZPNbhElh0SPzheRmzA+S1Gc=; b=rrY9boyYQLlrCMg3B82ApBf77m
	4u20ugIPr446534HlrJ3UKFEfNBD7TOBQIMBghM5UDfXJ6GTIBbCP2sZtHx+VPRLQD7tYoeml5mch
	BzHR443B/l88uxreKTxIwKaUexpLyYV6xbeKqWPJr5aL7mNIpZ9ekcmFbsFK5f3s8AxIM7eZjbYhx
	PUJoDtK5dU90jKugA0AmC4Mw0uOFNaFZjZCVnWAo0XITWDHuTN7VSQKfSetb/sUBtMjRilt9ywz1p
	jk+IocehBFp69RhQ6/FtP4pFUmd5Gwq9TfRBRDCYNrhXSvON22FmDfiRTRCNjDfrryhr4zu5EhU5y
	KCUuAEPQ==;
Received: from [94.239.20.48] (port=44586 helo=[192.168.1.98])
	by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96)
	(envelope-from <gustavo@embeddedor.com>)
	id 1qjkBA-004H78-2r;
	Fri, 22 Sep 2023 12:43:01 -0500
Message-ID: <9fd84065-4191-c8c6-43fa-01eda9865dd2@embeddedor.com>
Date: Fri, 22 Sep 2023 19:43:57 -0600
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 01/14] ipv4: Annotate struct fib_info with __counted_by
Content-Language: en-US
To: Kees Cook <keescook@chromium.org>, Jakub Kicinski <kuba@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>, David Ahern
 <dsahern@kernel.org>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
 Jamal Hadi Salim <jhs@mojatatu.com>, Martin KaFai Lau
 <martin.lau@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 Alexei Starovoitov <ast@kernel.org>, Yisen Zhuang <yisen.zhuang@huawei.com>,
 Salil Mehta <salil.mehta@huawei.com>, Claudiu Manoil
 <claudiu.manoil@nxp.com>, Vladimir Oltean <vladimir.oltean@nxp.com>,
 "K. Y. Srinivasan" <kys@microsoft.com>,
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
 Dexuan Cui <decui@microsoft.com>, Long Li <longli@microsoft.com>,
 Ajay Sharma <sharmaajay@microsoft.com>, Alex Elder <elder@kernel.org>,
 Pravin B Shelar <pshelar@ovn.org>, Shaokun Zhang
 <zhangshaokun@hisilicon.com>, Cong Wang <xiyou.wangcong@gmail.com>,
 Jiri Pirko <jiri@resnulli.us>, Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <ndesaulniers@google.com>, Tom Rix <trix@redhat.com>,
 Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org,
 linux-hyperv@vger.kernel.org, linux-rdma@vger.kernel.org,
 dev@openvswitch.org, linux-parisc@vger.kernel.org, llvm@lists.linux.dev,
 linux-hardening@vger.kernel.org
References: <20230922172449.work.906-kees@kernel.org>
 <20230922172858.3822653-1-keescook@chromium.org>
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <20230922172858.3822653-1-keescook@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 94.239.20.48
X-Source-L: No
X-Exim-ID: 1qjkBA-004H78-2r
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.1.98]) [94.239.20.48]:44586
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 6
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfCo6z3hRe6W7IJ3P5csdGlWnd0UVIdH6bYtEQlzSQjBwiel7qFnMflUjTHAlfWO4v4fS7wJ/YFE/9H0keCiydVWs0q9Lf3RoLP8YbxUqNW/S5hLjbSqx
 7hM3BBTT162RQajdkRnFaUGX99bVcZdy/wYu6ilvtBmSGnJBbraF+sI2uvACtI20VoR4WqESvsYbFtessCxMWdeiKrSWpUM6i57MHnOCh1X/lxchC8HbST7z
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_06_12,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 9/22/23 11:28, Kees Cook wrote:
> Prepare for the coming implementation by GCC and Clang of the __counted_by
> attribute. Flexible array members annotated with __counted_by can have
> their accesses bounds-checked at run-time checking via CONFIG_UBSAN_BOUNDS
> (for array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
> functions).
> 
> As found with Coccinelle[1], add __counted_by for struct fib_info.
> 
> [1] https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/counted_by.cocci
> 
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: David Ahern <dsahern@kernel.org>
> Cc: Eric Dumazet <edumazet@google.com>
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: Paolo Abeni <pabeni@redhat.com>
> Cc: netdev@vger.kernel.org
> Signed-off-by: Kees Cook <keescook@chromium.org>

Reviewed-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Thanks
-- 
Gustavo

> ---
>   include/net/ip_fib.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/net/ip_fib.h b/include/net/ip_fib.h
> index f0c13864180e..84b0a82c9df4 100644
> --- a/include/net/ip_fib.h
> +++ b/include/net/ip_fib.h
> @@ -156,7 +156,7 @@ struct fib_info {
>   	bool			nh_updated;
>   	struct nexthop		*nh;
>   	struct rcu_head		rcu;
> -	struct fib_nh		fib_nh[];
> +	struct fib_nh		fib_nh[] __counted_by(fib_nhs);
>   };
>   
>   

