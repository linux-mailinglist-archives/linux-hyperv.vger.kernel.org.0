Return-Path: <linux-hyperv+bounces-530-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 381357CAECA
	for <lists+linux-hyperv@lfdr.de>; Mon, 16 Oct 2023 18:18:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E71D9281423
	for <lists+linux-hyperv@lfdr.de>; Mon, 16 Oct 2023 16:18:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4272130CF6;
	Mon, 16 Oct 2023 16:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0Dr8mNYN"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 035EB30CF5
	for <linux-hyperv@vger.kernel.org>; Mon, 16 Oct 2023 16:18:24 +0000 (UTC)
Received: from mail-vs1-xe2d.google.com (mail-vs1-xe2d.google.com [IPv6:2607:f8b0:4864:20::e2d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B13CA1FE9
	for <linux-hyperv@vger.kernel.org>; Mon, 16 Oct 2023 09:17:56 -0700 (PDT)
Received: by mail-vs1-xe2d.google.com with SMTP id ada2fe7eead31-457c441555cso1307772137.3
        for <linux-hyperv@vger.kernel.org>; Mon, 16 Oct 2023 09:17:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697473075; x=1698077875; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qPeTD07qqs/9WMRTaqwTdVF4qIMjIWgtLzI+6IjZFGA=;
        b=0Dr8mNYNh3M6VFqimX2BbwYwxL7+zyI0gxgSvvEQVGv/MXC9NTsRaETlKJzt92xUIK
         cLs1n2aWXpIU4qpXtlUpv3/Q6CzBgK7qdWyj+siHEfFcCU+9xdcwXaCML0JEThGoZ59U
         Syi9uw0MAX0uIEfxOEjzysJ+GYh7F34KxuDeR0mlA9yg5IkT2gcx8C+crOUG+kfa401M
         B/+i63OalbFmxaTCMhYh5bgosbCQisKTK7/7FZUV2josXeyr6paPMCSv3XxKU79dc9dF
         lrUKvLVP/q2Jw4r+15ff+bCG0ir25J5GOKn0OImg0hIhzEOY0o4WTUU8ekmx14f53Lc+
         U/oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697473075; x=1698077875;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qPeTD07qqs/9WMRTaqwTdVF4qIMjIWgtLzI+6IjZFGA=;
        b=D3o0V1rF3dDYnDvwI9FXR49FDneuEusdAMbBXirowdJh1jsud2kcui+nGj9jfekVpP
         v1a+KSP2epvzkdSb1dsVj1w46ea//vaQucYYjHm6xZ4leFLwEhdIahVVuGbtIVou9Avh
         2sb4m1MQcuL4JQi23VhcicHUjFNvQjCBFUY/W5lvnuW1WHoqUCbXyNcCbrjMljkDvPmx
         ZH/H9kNds7Tzglb5NXrxgp0o+4rSUfBMHJT/ogEh/igK8xvnij8xCbtgaIeI45hWaO3z
         scnzgccm2reTSuiiOMi4Gewx8U9XP4j3Nn0ZcnRwOK4FvaFw8TpRSk3N4+eqyQvaZV2L
         7YfQ==
X-Gm-Message-State: AOJu0Yzg/SoINk1R50JTTLXW80PLGLKjuz6T2fU2kuYcSdlxXXwVo2h8
	D9PHxZked0B/t8E5v7/w/n1m5ub1rFKxCw9L1nSz6w==
X-Google-Smtp-Source: AGHT+IGpDaubxMSCRiY/o1FMVr9viD4yKvVnPizkIQyndGhX6cy8BTdwjYsqpKr0nKCwwYyjb2otqgm5nXNHzR0UFaM=
X-Received: by 2002:a05:6102:20de:b0:457:ba95:6271 with SMTP id
 i30-20020a05610220de00b00457ba956271mr7104809vsr.31.1697473075037; Mon, 16
 Oct 2023 09:17:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1697056244-21888-1-git-send-email-haiyangz@microsoft.com>
In-Reply-To: <1697056244-21888-1-git-send-email-haiyangz@microsoft.com>
From: Neal Cardwell <ncardwell@google.com>
Date: Mon, 16 Oct 2023 12:17:37 -0400
Message-ID: <CADVnQy=iZf10mpeG0=BseAapd0LKPRnKdD=M-3AEs5VApiS=CA@mail.gmail.com>
Subject: Re: [PATCH net-next,v3] tcp: Set pingpong threshold via sysctl
To: Haiyang Zhang <haiyangz@microsoft.com>
Cc: linux-hyperv@vger.kernel.org, netdev@vger.kernel.org, kys@microsoft.com, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	corbet@lwn.net, dsahern@kernel.org, ycheng@google.com, kuniyu@amazon.com, 
	morleyd@google.com, mfreemon@cloudflare.com, mubashirq@google.com, 
	linux-doc@vger.kernel.org, weiwan@google.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Oct 11, 2023 at 4:31=E2=80=AFPM Haiyang Zhang <haiyangz@microsoft.c=
om> wrote:
>
> TCP pingpong threshold is 1 by default. But some applications, like SQL D=
B
> may prefer a higher pingpong threshold to activate delayed acks in quick
> ack mode for better performance.
>
> The pingpong threshold and related code were changed to 3 in the year
> 2019 in:
>   commit 4a41f453bedf ("tcp: change pingpong threshold to 3")
> And reverted to 1 in the year 2022 in:
>   commit 4d8f24eeedc5 ("Revert "tcp: change pingpong threshold to 3"")
>
> There is no single value that fits all applications.
> Add net.ipv4.tcp_pingpong_thresh sysctl tunable, so it can be tuned for
> optimal performance based on the application needs.
>
> Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
> ---
> v3: Updated doc as suggested by Neal Cardwell.
>     Updated variable location in struct netns_ipv4 as suggested by Kuniyu=
ki
>     Iwashima.
>
> v2: Make it per-namesapce setting, and other updates suggested by Neal Ca=
rdwell,
> and Kuniyuki Iwashima.
> ---
>  Documentation/networking/ip-sysctl.rst | 13 +++++++++++++
>  include/net/inet_connection_sock.h     | 16 ++++++++++++----
>  include/net/netns/ipv4.h               |  2 ++
>  net/ipv4/sysctl_net_ipv4.c             |  8 ++++++++
>  net/ipv4/tcp_ipv4.c                    |  2 ++
>  net/ipv4/tcp_output.c                  |  4 ++--
>  6 files changed, 39 insertions(+), 6 deletions(-)

Acked-by: Neal Cardwell <ncardwell@google.com>

Thanks!

neal

