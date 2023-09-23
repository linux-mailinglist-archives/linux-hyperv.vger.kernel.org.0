Return-Path: <linux-hyperv+bounces-171-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EB087AB814
	for <lists+linux-hyperv@lfdr.de>; Fri, 22 Sep 2023 19:49:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sy.mirrors.kernel.org (Postfix) with ESMTP id 6512EB2089F
	for <lists+linux-hyperv@lfdr.de>; Fri, 22 Sep 2023 17:49:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DEF243A87;
	Fri, 22 Sep 2023 17:49:52 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00FB941E21
	for <linux-hyperv@vger.kernel.org>; Fri, 22 Sep 2023 17:49:50 +0000 (UTC)
Received: from omta36.uswest2.a.cloudfilter.net (omta36.uswest2.a.cloudfilter.net [35.89.44.35])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F018139
	for <linux-hyperv@vger.kernel.org>; Fri, 22 Sep 2023 10:49:49 -0700 (PDT)
Received: from eig-obgw-6005a.ext.cloudfilter.net ([10.0.30.201])
	by cmsmtp with ESMTP
	id jjINqsSrwEoVsjkHkqCrcC; Fri, 22 Sep 2023 17:49:48 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
	by cmsmtp with ESMTPS
	id jkHkqEUCx6FyhjkHkqvDMg; Fri, 22 Sep 2023 17:49:48 +0000
X-Authority-Analysis: v=2.4 cv=Y8PrDzSN c=1 sm=1 tr=0 ts=650dd3bc
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=P7XfKmiOJ4/qXqHZrN7ymg==:17
 a=OWjo9vPv0XrRhIrVQ50Ab3nP57M=:19 a=dLZJa+xiwSxG16/P+YVxDGlgEgI=:19
 a=IkcTkHD0fZMA:10 a=zNV7Rl7Rt7sA:10 a=wYkD_t78qR0A:10 a=NEAV23lmAAAA:8
 a=J1Y8HTJGAAAA:8 a=VwQbUJbxAAAA:8 a=1XWaLZrsAAAA:8 a=cm27Pg_UAAAA:8
 a=e5xG7rUhXx-5Dd8OgBAA:9 a=QEXdDO2ut3YA:10 a=y1Q9-5lHfBjTkpIzbSAN:22
 a=AjGcO6oz07-iQ99wixmX:22 a=xmb-EsYY8bH0VWELuYED:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=71wuTBueWZAsw5Nv2J92OF9IxO/5J5d8n1IYa3AcwDQ=; b=sXOt9XzZabxT+1P2H/GRHGe1Rc
	WbH0iwTO0N0TYMZ4HxF9EnOlBI0X6kBtalq4UgLcTzS82C1OfcfpsgA530jk25h+vlq4zVmGiFide
	54Q9XuRULvnVkOCe9i8hnBU+/cmPCvyJnu/Qa0EEJgb47ZwExGP/nzYX9JPoysdAytm8jS1bgPUp8
	LLeWRwgEbNq8aCupwQWFGoBTpitPuv9glJVfTZ6FEVduSXKDdXSnz4w+w+qsGW6XGV07GhdxCreIB
	1BFZgDpGum5rMuOwGfNoSNEf4yqN/VrBTcJ09fZ0iztzaCW/izRpjSGkk8cfTChzAdWVjF5x4zEmW
	ijhhX6ag==;
Received: from [94.239.20.48] (port=37230 helo=[192.168.1.98])
	by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96)
	(envelope-from <gustavo@embeddedor.com>)
	id 1qjkHe-004NOP-25;
	Fri, 22 Sep 2023 12:49:42 -0500
Message-ID: <3bc23613-d1d0-5a05-3057-86933b2c844a@embeddedor.com>
Date: Fri, 22 Sep 2023 19:50:39 -0600
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 02/14] ipv4/igmp: Annotate struct ip_sf_socklist with
 __counted_by
Content-Language: en-US
To: Kees Cook <keescook@chromium.org>, Jakub Kicinski <kuba@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>,
 Martin KaFai Lau <martin.lau@kernel.org>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 Eric Dumazet <edumazet@google.com>, Alexei Starovoitov <ast@kernel.org>,
 Jamal Hadi Salim <jhs@mojatatu.com>, David Ahern <dsahern@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Yisen Zhuang <yisen.zhuang@huawei.com>,
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
 netdev@vger.kernel.org, linux-hyperv@vger.kernel.org,
 linux-rdma@vger.kernel.org, dev@openvswitch.org,
 linux-parisc@vger.kernel.org, llvm@lists.linux.dev,
 linux-hardening@vger.kernel.org
References: <20230922172449.work.906-kees@kernel.org>
 <20230922172858.3822653-2-keescook@chromium.org>
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <20230922172858.3822653-2-keescook@chromium.org>
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
X-Exim-ID: 1qjkHe-004NOP-25
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.1.98]) [94.239.20.48]:37230
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 43
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfGIthhO8TcMf8OH9+nhUDqsyByf5EG8BXghVypMo2XKmy0ULKo+Gex0SZuepGKL5CeYcVmX/kko3m+2KaCTvBCm3OOxGx0bKuP2JWM3YfnwnvapeCAxI
 fnJNOjg1mhNJTxn4aWfT7bNtXpDFqhRz7U+8QDgs2SegviYJ+x08AzB3UPMlpOFaVnhEXFH+kt48uBUYTYyGMpCIIEagzPhVScDMNgGTjMLrGqQdZhZZH311
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_06_12,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
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
> As found with Coccinelle[1], add __counted_by for struct ip_sf_socklist.
> 
> [1] https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/counted_by.cocci
> 
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Martin KaFai Lau <martin.lau@kernel.org>
> Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>
> Cc: Eric Dumazet <edumazet@google.com>
> Cc: Alexei Starovoitov <ast@kernel.org>
> Cc: Jakub Kicinski <kuba@kernel.org>
> Signed-off-by: Kees Cook <keescook@chromium.org>

Reviewed-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Thanks
-- 
Gustavo

> ---
>   include/linux/igmp.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/igmp.h b/include/linux/igmp.h
> index ebf4349a53af..5171231f70a8 100644
> --- a/include/linux/igmp.h
> +++ b/include/linux/igmp.h
> @@ -39,7 +39,7 @@ struct ip_sf_socklist {
>   	unsigned int		sl_max;
>   	unsigned int		sl_count;
>   	struct rcu_head		rcu;
> -	__be32			sl_addr[];
> +	__be32			sl_addr[] __counted_by(sl_max);
>   };
>   
>   #define IP_SFBLOCK	10	/* allocate this many at once */

