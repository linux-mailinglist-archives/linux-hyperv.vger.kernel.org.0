Return-Path: <linux-hyperv+bounces-1184-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E948D802B80
	for <lists+linux-hyperv@lfdr.de>; Mon,  4 Dec 2023 06:58:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A3837280A99
	for <lists+linux-hyperv@lfdr.de>; Mon,  4 Dec 2023 05:58:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA821539F;
	Mon,  4 Dec 2023 05:58:26 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 239E9192;
	Sun,  3 Dec 2023 21:58:12 -0800 (PST)
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1cff3a03dfaso11288945ad.3;
        Sun, 03 Dec 2023 21:58:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701669491; x=1702274291;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mH7c+Pqxj4Crkp7emUE+D2KDKHscrm0H2Ws3X/+mLE4=;
        b=rwMpXQ/Dsx3PJZg2nuoURoxKdtwYWtzKzfliYv+yV1CTF/ysR7wLTj+tkSBl7r6i/T
         pbdu8rvmeXMBkN5RbGx+NyviR3c8GotSfO8XTW4h+ymhSk7cucwdOb332/jJtpTJmVao
         yJ20+wsgkqgmGRbSJR7GmMEgXKh4Xu/nZj/2QK6+hjcFG4xxJ4loG19kVcqcqXOD4C6g
         10f2E5sPc9pt+Vn9wrG0vZBDgjgLDv+PaS8EgcU1iy21SeD9UqJm8ah2k7Gll/JdG222
         ncIDz1ClbI6waHyEy+lR0vfopDP3AVeA3E6VZCGGChBSot6OjkHKTmjcdyiTaYkk0gTY
         5lOQ==
X-Gm-Message-State: AOJu0YzIz1RbqiC1lQe6q1hZoY128+fWChC9g0fc6nPJcRW7rmsZwyIF
	xUqzgRbXYdWLgkjqv/+/090=
X-Google-Smtp-Source: AGHT+IHeRXDeAgAlRj3lYBUI6cO8QZedS20zcb35oAgelMFTgGlsYmrODODsrVI1M7cOETOOSYv2Cw==
X-Received: by 2002:a17:902:e549:b0:1d0:6ffd:8341 with SMTP id n9-20020a170902e54900b001d06ffd8341mr852253plf.76.1701669491482;
        Sun, 03 Dec 2023 21:58:11 -0800 (PST)
Received: from liuwe-devbox-debian-v2 ([20.69.120.36])
        by smtp.gmail.com with ESMTPSA id m3-20020a170902c44300b001d084f4fad5sm2363166plm.2.2023.12.03.21.58.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Dec 2023 21:58:11 -0800 (PST)
Date: Mon, 4 Dec 2023 05:58:09 +0000
From: Wei Liu <wei.liu@kernel.org>
To: Yury Norov <yury.norov@gmail.com>
Cc: linux-kernel@vger.kernel.org, "K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	linux-hyperv@vger.kernel.org, linux-pci@vger.kernel.org,
	Jan Kara <jack@suse.cz>,
	Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>,
	Matthew Wilcox <willy@infradead.org>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Maxim Kuvyrkov <maxim.kuvyrkov@linaro.org>,
	Alexey Klimov <klimov.linux@gmail.com>,
	Bart Van Assche <bvanassche@acm.org>,
	Sergey Shtylyov <s.shtylyov@omp.ru>,
	Michael Kelley <mhklinux@outlook.com>
Subject: Re: [PATCH v2 14/35] PCI: hv: switch hv_get_dom_num() to use atomic
 find_bit()
Message-ID: <ZW1qcVWfjCvz0JRZ@liuwe-devbox-debian-v2>
References: <20231203192422.539300-1-yury.norov@gmail.com>
 <20231203193307.542794-1-yury.norov@gmail.com>
 <20231203193307.542794-13-yury.norov@gmail.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231203193307.542794-13-yury.norov@gmail.com>

On Sun, Dec 03, 2023 at 11:32:46AM -0800, Yury Norov wrote:
> The function traverses bitmap with for_each_clear_bit() just to allocate
> a bit atomically. We can do it better with a dedicated find_and_set_bit().
> 
> Signed-off-by: Yury Norov <yury.norov@gmail.com>
> Reviewed-by: Michael Kelley <mhklinux@outlook.com>

Acked-by: Wei Liu <wei.liu@kernel.org>

