Return-Path: <linux-hyperv+bounces-1057-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 914EB7F9F13
	for <lists+linux-hyperv@lfdr.de>; Mon, 27 Nov 2023 12:54:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4BC96281638
	for <lists+linux-hyperv@lfdr.de>; Mon, 27 Nov 2023 11:54:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75DC128E0D;
	Mon, 27 Nov 2023 11:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hgbicCmJ"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3583C19B
	for <linux-hyperv@vger.kernel.org>; Mon, 27 Nov 2023 03:53:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1701086023;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8dFDcEA9Z7jcvOeDtvs4nt1f6dFZbdEOKwzb8RSGdjs=;
	b=hgbicCmJF5CW/KGwtzbaWB4Ua/mOkGjDrECL+uGRCaD/qBQBUpuD4STlc0t7XnddDqirIn
	dyCeq4OrN+2IcMbIck7DwfOuLc4XFqTpdq80qfdBpUbSQh5CuvBQt9tHMNDMMTdWUOrtlt
	eyd+JMiRbyEAUPzRdZF9/QDnFha7l3s=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-275-9oPN7PMbNuSphUzQq4mfhQ-1; Mon, 27 Nov 2023 06:53:42 -0500
X-MC-Unique: 9oPN7PMbNuSphUzQq4mfhQ-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-9fe081ac4b8so84898466b.1
        for <linux-hyperv@vger.kernel.org>; Mon, 27 Nov 2023 03:53:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701086021; x=1701690821;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8dFDcEA9Z7jcvOeDtvs4nt1f6dFZbdEOKwzb8RSGdjs=;
        b=tPEoZfTTGrRLx8DYoeHLHgGoBE/HIBIRbwVjPQwQBMMFT1h2q7KmbCJeH6hVa1J4UO
         neTsOmaMm7QhIyUAsqz3yPVzZTOzLCThZcyIHkXa1a1ClpBppQZDZfjfJOJmUbM+2kXs
         vKeLPVawLCwedSmzqDMAmqsYMV7NV8SqoKpeTQxKgKPsm77hItN9P0qBXInrG5GH1BtH
         /yaOcojxBcOm75+ZKG1D+pJgr4uvGJGLEwqKfPF4JZsRgTMHTK1QXYNCVvnvol6p1ddq
         uSw9aSmKXWVLbSLbRLnNh8wL+zigY5pKIYxLpQtWa0ozfCWM3+O97yBFuTtvSRslbrzx
         MmIA==
X-Gm-Message-State: AOJu0YyLf0541gig+KSiYzqSd7ryyFjsQpa4PVAZXcKpSsCR71XUALMh
	Vg7XKnpWMERvAdlCNS3X1/uw116WLyUvXBY3yMp1lJhWs/1VtxfXoDK4zrxLQlv9i8E6hELMuDQ
	K/ObAEEo2kKIjwiQHLCWRfv/3+t9JyWFI
X-Received: by 2002:a17:906:c30c:b0:a04:9f07:cb7 with SMTP id s12-20020a170906c30c00b00a049f070cb7mr7102993ejz.2.1701086020797;
        Mon, 27 Nov 2023 03:53:40 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFMhVv3wMdQRPOR1xkomAIWGJ5bbogBeJn6ZTccLM2kT5Zm2YVoX1QPW5+GpEUs9yK0xrOnuA==
X-Received: by 2002:a17:906:c30c:b0:a04:9f07:cb7 with SMTP id s12-20020a170906c30c00b00a049f070cb7mr7102969ejz.2.1701086020387;
        Mon, 27 Nov 2023 03:53:40 -0800 (PST)
Received: from gerbillo.redhat.com (host-87-11-7-253.retail.telecomitalia.it. [87.11.7.253])
        by smtp.gmail.com with ESMTPSA id bu8-20020a170906a14800b009e505954becsm5617452ejb.107.2023.11.27.03.53.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Nov 2023 03:53:40 -0800 (PST)
Message-ID: <1cdb1f702ba74e42c09f6f6b6ff2ca223ccca14f.camel@redhat.com>
Subject: Re: [PATCH] net :mana :Add remaining GDMA stats for MANA to ethtool
From: Paolo Abeni <pabeni@redhat.com>
To: Shradha Gupta <shradhagupta@linux.microsoft.com>, 
	linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org, 
	linux-rdma@vger.kernel.org, netdev@vger.kernel.org
Cc: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Ajay Sharma <sharmaajay@microsoft.com>, Leon Romanovsky <leon@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, Sebastian Andrzej Siewior
 <bigeasy@linutronix.de>, "K. Y. Srinivasan" <kys@microsoft.com>, Haiyang
 Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>,  Dexuan Cui
 <decui@microsoft.com>, Long Li <longli@microsoft.com>, Michael Kelley
 <mikelley@microsoft.com>,  Shradha Gupta <shradhagupta@microsoft.com>
Date: Mon, 27 Nov 2023 12:53:38 +0100
In-Reply-To: <1700830950-803-1-git-send-email-shradhagupta@linux.microsoft.com>
References: 
	<1700830950-803-1-git-send-email-shradhagupta@linux.microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi,

On Fri, 2023-11-24 at 05:02 -0800, Shradha Gupta wrote:
> Extend performance counter stats in 'ethtool -S <interface>'
> for MANA VF to include all GDMA stat counter.
>=20
> Tested-on: Ubuntu22
> Testcases:
> 1. LISA testcase:
> PERF-NETWORK-TCP-THROUGHPUT-MULTICONNECTION-NTTTCP-Synthetic
> 2. LISA testcase:
> PERF-NETWORK-TCP-THROUGHPUT-MULTICONNECTION-NTTTCP-SRIOV
>=20
> Signed-off-by: Shradha Gupta <shradhagupta@linux.microsoft.com>

For the next submission, please remember to include the target tree in
the subj prefix:

https://elixir.bootlin.com/linux/latest/source/Documentation/process/mainta=
iner-netdev.rst#L12

(in this case 'net-next').

No additional actions needed here.

Cheers,

Paolo


