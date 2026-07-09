Return-Path: <linux-hyperv+bounces-11884-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id p/5PDOTJT2qToQIAu9opvQ
	(envelope-from <linux-hyperv+bounces-11884-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 09 Jul 2026 18:18:44 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 312D7733625
	for <lists+linux-hyperv@lfdr.de>; Thu, 09 Jul 2026 18:18:43 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=web.de header.s=s29768273 header.b=ltRhibzM;
	dmarc=pass (policy=quarantine) header.from=web.de;
	spf=pass (mail.lfdr.de: domain of "linux-hyperv+bounces-11884-lists+linux-hyperv=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="linux-hyperv+bounces-11884-lists+linux-hyperv=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B0CE13063DC6
	for <lists+linux-hyperv@lfdr.de>; Thu,  9 Jul 2026 16:05:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A009A42E8F1;
	Thu,  9 Jul 2026 16:05:38 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D03C427A0C;
	Thu,  9 Jul 2026 16:05:35 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783613138; cv=none; b=J7YmBMoRtuLaB+lA4RSzOuEfwSThCoZhM2R65JFp6tJHdmN6m9AYBtIq9d27kRYytb55qb8MgnVEo2PLVvuXB9JyksdB4dJ5YFE7d5rb9hTVcd4ygWA1hTCJiqwWmno+PIu/Q33iawkTsali7T3WOS8ZZYtD+dxcRVttMHMdxLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783613138; c=relaxed/simple;
	bh=3qGERBjwIsu2SRW/VWNmeqamu1vmEeoG0Ypy5Joc/q8=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=Kw+GdYNVw2NYsWTvvRS8YLxLzKNoF/b2s2sAz2hY6cfbs2E8SK/WUK8hYDQTVDxXxvbxen0nX9lHlV9lCiLqXNRYBWHAq05oXTtbGPUzri08Ub2VzD/5pECgXlNK38joMah8pydbho8HvJDYjq/c+LClvqBKp2Sq9PTLzjcZo08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=ltRhibzM; arc=none smtp.client-ip=212.227.17.11
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1783613121; x=1784217921; i=markus.elfring@web.de;
	bh=3qGERBjwIsu2SRW/VWNmeqamu1vmEeoG0Ypy5Joc/q8=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=ltRhibzM50z/yN7svMcJgK+NAPNULATZRdrY7fm2b5GvQFy8mvOdrJCFV5qVtCIv
	 nsbmq9BebCODREbpnzR9ZYVPNTlGfqCCwE3xBSxdWUzpXMq7vbjioaEH+mqwlcjmU
	 eK7COusyC/Ic4CigAIQ/Cpie6j1S4+emQD5yNdjZn0PdK0riPgkhD+4mrqx+9owOX
	 /1ualzBIdTWk56rHFt+5vEuqV4KIu3nr3TaTK267X48tMYBCR+NM+andITDuY/P4j
	 TguTcndyNw5pl3ouK6TTM7KeeMK07N4WmlNDPGi/p83AOnpc9+k/LfwhrcIqaTzlq
	 IzCZ1J/l2jgsEi2/NQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MlsKH-1xOvRa0zi7-00kBSR; Thu, 09
 Jul 2026 18:05:21 +0200
Message-ID: <79383daa-8c38-4858-8ed1-f6e69aeeec42@web.de>
Date: Thu, 9 Jul 2026 18:05:18 +0200
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Yi Xie <xieyi@kylinos.cn>, linux-hyperv@vger.kernel.org,
 Haiyang Zhang <haiyangz@microsoft.com>,
 Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>,
 "K. Y. Srinivasan" <kys@microsoft.com>, Wei Liu <wei.liu@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>
References: <20260708012852.36824-1-xieyi@kylinos.cn>
Subject: Re: [PATCH] mshv: fix fd leak in mshv_ioctl_create_vtl()
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20260708012852.36824-1-xieyi@kylinos.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:grqdu1mnoUcnHt7Inw/1aX/JXyCddWKjB8PltBkXqc6D4otVtnO
 kXt8FQ+U9BattavRsB4d6OgiZqjNgAqlaBO7U4//tPxMWVkcI9pNXv240Zd5fakJunPxkGF
 +mapndwh1UBxPXwqaBrd6Kf67dShW5R78X+SrtdjksHcbZ+z8d5wJRX4Zzkyts56FLSPFlB
 jTLzsec1ZSsUZu8VQg/jQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:YBJnfdIsOag=;HEUJ+r40YBwvpgyg5AOzpGy/7Ed
 UKfthhp7nVQzUQ1VOb5Vh9JtVyqdZoBYLou0K4lVqJRi6tzKnqRl9wizH5fjgmjdLnseNM4GZ
 8xcVQsathrRulG8ixhl27KeIj1hg6g0F5D/lHKjpDDijeED6zz/RikFZa367xNtIXF0vh8KVl
 UZH9ILeMKpTC54vH3nbndNt3MhuWGBM7mxkcloYD5SLUXEfGG4VHQYXWckYb9VaSMybW0aNj9
 +PjOEjY3PezItavA/DFa7dTLFC/A2WSRw5ULOCd5r4ttdsVcYhQRd/HSiZfL4RbW4IL0TKZxF
 4gWH3qxGaypKSD8Suxchsg7ivttcn5qFxo5JR5Ypl+wUac7eR7Go7lNrJOnL0LJctPfE2Lhrp
 CoY72/DJmw+dURby8cd/WUX38t+Upj3cmCRbpcD80lgjMiEVbrBfXM/9xwq4bsGLf6GPYhFsB
 ki0ReYsmGkulipduDf4pjWrzBHVLU0SZNrjjUvErg2mFxGQ26BZJ0VnMlI8o2l0bHMljN8r1T
 A2rCobNuknPXQVCG8CwilXnPizOIUzoysm6oGeuf/UTrNS0cdYc8s3UvKhAQoALmoH6DLYTRz
 DgjRF2si5KFzpAX6iG5nXTPbF2djkD4kRzJ5YzZWjIoHZqihpJDAHhEKuO/LbNWE7S7XeIfyH
 fxkoF+TdPQjfK77Y7STtRt0OlwsgXALwyLvUtzAT+kGCxcYHVQRj/qS6CMfYcGBp4q/fM6MNp
 FIID7qSM/YKGu0Gh8Uf1PuM1vDoCneV8Ec6FYpeN0LqtZReY3vql4q9BwQqiYvs+78B0to9Jo
 4iP0i0SXHdlPyuaGyXZIbwurmwpa6tC8kPduPioG5Gwo15N1U7Pt5JYuZcE5zdGXduEz+Rz6E
 uFabGR6cEQkLyQofHiTg4s9D0Y1JqtlUCVVgwh65iKrC0Ny4afogUrz4eeN+us8oPb7luUEsS
 KwZ/HvpP34G2RPTpf/WGGsNKVolwSl27X6dWZmfssNN0TkUZ8eZMZDHD+0Pf09+Ftwo1OLLRJ
 ds/XDNcRJtjWIccR6CFgyL2BZOG4oFLd/EMIRdHhQGQjpVMwr1lYVBdNy+cKHZaMfnCC3wdIj
 5xMW+Vr+501VmPFtneDjaeQTY0gqjlwlgClVa9Ts9KteJzauJ0Rggs+pM4DWOckxEmwCyQhZ4
 ejhnHnFl1W8Ah8bJ4AKemzRE9u9cfqWAC1Nn3gkIL/FMGUPe9NoavOrVeR9BloTTWaIB7PphO
 v4O5mcaDoWh+c4dbMPL/NwoTG5UXBo5IzTKnhyu7w41Z4NiN6eF8trQXE8RCPJDEoIG4EEdIj
 fO+XyiaCo5FikgHRg7+m/BvVVphGHxbrYMZuFjCfZo8SpwivYVCrblTcXy5ptHWRKgphtjn3G
 lyE9Wo6M8DGoREv0KcdHG+auNk/Zmlc2R98MrrLMqqNXJblfxqm3wH5fQgSr1FoCpwntZHS4I
 kR1+43YDrvZ9mwEkx+PQNT9Pk3LQ45THGdBIpzxwuAWLAU243PTes5w/seZM1ZhpDrQHdFxM7
 PTQRFUkYIo+3IEVUUKIAIHCQMBC7CGRW0Tu1OO/lBzKV0FwmEqi48iK150f1yxUBoni3IFn0s
 aDIe9S/t/qzlETvhLnDmHglYQg3TRf3k7BuHREjY340h1sPoI3hDbB27gB7UbfMSmgaBy5La6
 0IfRWIqaQ4nllj3+QKfoxHnEB2H7osvA3PdHIho/3zO4cBShCSvnlZTQco1oMAblHDAZsv64Y
 fkOZZlCMZjE7NTMoSk6Cdl3ub0cS+tVvAb9JAHfFsjxaRVosrDARqohhATHkoRPdNlRHZt9uH
 mBGMSv0cnZwrQdF3O6bAfru7ghuGBTO/iwMyy30UOpj4yMmmH6wTrDSsdkWNkV8qy22EYDQH0
 kcWg4JTTTIlbHvcRThAs9VWKQMhVuUR/OHlCYOpOCdNY3XvMagdNAefpRVtqSh/vRol1uCC3K
 8gIgpTksslHDJA+mtO2Iw6U5n0EmKrStP/iMfllpqAGaiBmTgXU7Oi+sF7zjm8o8gZylunY45
 HSkG+jd194H/c6TqIlW8LdI1jZn8I3FkCNwbKu5AgySJTwZXmfYaXmgEEL+OU92iFEYXUBHPp
 sggj6u33DaPrDvDdmUFfhsgnfsTo+KcMUpCTwBdquWAi7d9GRYR096JqgStryKClAE/lKGn9b
 LHflkZtjEVWJ3qbPPo1KNoY5kjTIJ+hjlP3htrvsvN79vVgqWQleVdzDIHelVdQgUndI3UJ9W
 WKtyF6JD7+IG3/n5TQDAqLTLGP9NlWSqTavHFIGrLahhXvbcDacS8VxpQD/6/M5I2JV1eonuA
 H4M3Z7hcCBxF9fcNgo7y0tcWDv5NT4ZMohBXstd/KJWKLw+MUzpLg4e5yq+QlJOfkr4AoQ+it
 RKnRVeSCWAgruFeat4ZPhAAi3tzMUd6V6gJb4VAbME6XoqQj5dy7DxdTaKcVZRNOTuRmgE11l
 /1tYX4kNj5U6VG7znvtB0woTFOjTHcyw1Og4BcDy5A6f2LmmFhwb+RAJAC4cp2+GxhkERGmM+
 ploeHpvDWv6HIxrIjfoPmriU+BIjMpRaAZZjPdEOQ7N5i9jmyoyk9Wxi3TzUNjaHs8eHhp5iD
 EPUi9aalrwobMXtWqaWRAOYw0tQ3ENX9P6zJ1AcadsmTSmiHUgQ7heHmai995YpWaLuE9FMtw
 pjN9NnsIKftYFsaJICDVQt3ZxbMj0wx80uCZYsEOicA3C0DmZLq+KtcnPyFZDcSsJ61rd4e9u
 W2cvtbeqsirlYTXAQESYJubbK7EYUSIzB4E7JXikPKi9fAsUw8exaymFuhMse2fnbmy4Q8P0X
 NtvgSYShzp74R73j24CIvmXLPPtf7LsBIM+gRFYhydsZ9fYLBSeayyTkdt7R4xUaNyZge1I9E
 xzrVnBD3CYw6B1DXu9s56pEzWwF/BI3g6jyXO/qhda/yju5eh4cnEV23f98bMlPPwEVMmzKie
 6oTH9OHrhD7BSsivUvYN+eKebokaLZlernHgnryI3OYrdidepRFtR8Cr6iZ6KSa0TbJoyFNgV
 e1tW7APWqdJIZ8QTXZCotrEC4nd51ARA2CVB0rSRoq+bRjmbpimC8MWMBb1n3jJtbzg9tGbrv
 n4gDyyEDj+/JkVCcRIyhVm77ER0/Tkf2BV7lTA3huc+2BAEJFgPd45B2UDhc2/l8kwX7I0Ee5
 ThPqYQ2gAAaZut/ciUHUHfMjjhgrqO5uq+U3xNWMODobYS1WOtyKSGKWHMSGz8pgbKw4tgVba
 VXE0YYcyS91huQEfMASg/uBk4QQxXks2xC2f7HVvCZQszikbA2nWc1Lr9A0jGC5MSxotynDXW
 1NrU7kVGHew/DC+GRVgy31i91fafd7ibiNdWFaXr3W2kArpgCaQgzZRuCgT3N0psVyh09En16
 CfLtEQmdoRAaWh7+wuJB5Qj292m15cW0U9aU3pRDW878gob94ucKemrpkQzSGSZQk02nDB8Oh
 CGSlvPKuOMGLmzzrAAm/qIVzfeLvDLSRHHGAxjEYP/4VoiXVgCL+JADthv7zO3V2qZ3bF7n2v
 /KHRpVx8CO9jrifz5QorY2SaHfohzwgf+/JH5I3Avef0oy5B3Ydl9C3anLFlnPRlrw1Vpt1ds
 ygxXsU02Y+gYR2KHioMlwu+C541oF/SUp8/zbSZdEFjqEpK0a4v6tiMVXdFcBalSCViOYHfaJ
 xSxzaBRpMy4linbXVD0UJlHx5o0029iGj8ac7e4Qy3CUVK6RLRUF/kY6LAadnM5jyL3UFnSLw
 sHV/Y9uHGsym1LET53c5MMzSG32gNyWVj+uFxDQNC62UxswqpMGMpAOYiGQHrJXNvWllNwJfk
 HDVqlLqVYi5ot9z4Lk1HzWf/f2caxGRlytpaE8OK8/eugnPiujyDqb3VjuAEkdlTEd3lSrQgn
 Mhcc35varAT6Yp3XDKrjYycchBHn5uixsYYF1+r5nQVlWp/8ElwA2B4/ZeiNexh0ozep7+ltF
 /WlOhzdD/ezWsWMXsSbCuxZly+dMlec+pRu2CBtj3TBxWEBMNBRFp9r5INtYDrhktU9EXKCGH
 UWj81oqMkxEIeMSNbQEpLMjWdhNhffq83NAIvrVjSqLwA0fuoYQ10EVCL/HkCBNCnaPqZU1Lq
 NB+loaNZW/kfdB0DFpnial0fyGjB3Edfufb8GS30Ghc0jLhsM2Tijhm1aK6ycaw8OVm5bJuzG
 U1UDskpMsRPOFbWoKOHRN85xZ6+1OiDkdEkdfPEc3Nejyrd+nOFF5pKY5wn+qkQWSZdkroh8e
 Mt7+SjcoStOXY/yJWE3hp5YuoSPEytXLcQR/tibHC+hQ0xgPbaAszJjCyNsmlbH4iB4aIi/XO
 2lmvcOycCrKOy34B25hWkfS2HfRRERJ1GvEc8Ly5uEEymLkM7dN7GbWljgal9F7povMczyC6E
 Vo1esY4nZXx3o8/1zG8DlBQgkLG4BO5E4Asww1NqH/dw7wzZzDCtnzgPlpZSsOauEqcNNKQCt
 rvr/mVVvRLqHu8BqU3kPm8O9T452YX5UY0LiqBgu5faievziWZk8buNQ3zqYqKtUy3acc4FdA
 0ef2q3RYVp5UwCIwQNNumEzSuM94Q5PkvVSBI0cz+L0yjr6WlE2DHKoqM+9ORp03WeYgLiELL
 8OnGm1D+PQODNhry+UstL3ppgjMO214HRfRRA8dKPuG9KvYFDZXsn06EJdCeky0Cf6pPxqubx
 V6MBhgc3gBNXLGohE0sb3CAb2JRKyrOAZMX+ON9PPqeg2gmfa97upY8pVZfiJ0EhDlx/hCO/A
 qTD5Jedy36JzC790GzNNdWDsz831QZgkxCodY0VsRrLAwvuTnkv2KOhwvYqRcwk7nHd8HUwln
 HI12aGqg4O1xWa2BnBmCB3TphgYtTPdzPlGK1lCy3WNoVquFYLVYPW3qwa0hXWKmpAka4WndR
 LDF5qKzhN2pKQ2krmmo4QbldjWCgryAJ1Yb+gU35SWz3MvowQHrEGvV+c4JMT4OY9cbeRT7EU
 ZHF0tSMzYNugutWPnWwDzUleETYBz2/uyVn1oMyKaU9lywDh9gzW2FpNSMPbo+aaX4YEKBu5i
 hKkYAdYQWHHKCo6I89VKPFq37HyYSYi6J6mLGIIrEkknSF85l+DRCt1+D/kdzsqtuPs+scTUl
 uAxgjf132d0r1y/1F5NsN0hcFClHBJjh17CkckiXEz5Hxx7B9EKP39K+gSpZ+t+N2lTkNwcG8
 YRHELIwUaT3LDtvhRhx39WgfnHCjq2L4FtuzSiTrEENOcFP9HKL5W9n0t3YJ6H5uRl6kkbqCh
 W9Pufc0vEsBfKoX4omNEMEhrY299R5jdXTzqqqt/zp59MGAzCjgQ9T/443NKIXtODfuPdbL6K
 ZN9yAh6slKhS++wz9Wq/1HK1l1dTa8G0+OEp8lO4/LArevUtoqthYaENLFffNAkCv1myZWMnc
 ZwHJ5m0u0xsDo3jGwZphKX1/nrgjSN5iFGtJGDdvq+Hfh2Ofu5a388x8VfRFOtcgg4x9IurkE
 UZ5ZrstT8A09djhvsnGNvCt6Ym64CULJ4VAQKmRqedY0eCeLQ7JGBKHibKCVOWNw39gq8dZ/V
 VeappHZiZ1LouIToQRdT4eE2oVNqlaxuu7AEJJ8o8ySPofv8gBr4bcsLJPHIfgBe1q/xnw==
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[web.de,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[web.de:s=s29768273];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-11884-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:xieyi@kylinos.cn,m:linux-hyperv@vger.kernel.org,m:haiyangz@microsoft.com,m:hamzamahfooz@linux.microsoft.com,m:kys@microsoft.com,m:wei.liu@kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[Markus.Elfring@web.de,linux-hyperv@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[web.de:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FREEMAIL_FROM(0.00)[web.de];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Markus.Elfring@web.de,linux-hyperv@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	TAGGED_RCPT(0.00)[linux-hyperv];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 312D7733625

> put_unused_fd() if anon_inode_getfile() fails.

How do you think about to add any tags (like =E2=80=9CFixes=E2=80=9D and =
=E2=80=9CCc=E2=80=9D) accordingly?

See also:
* https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/=
Documentation/process/submitting-patches.rst?h=3Dv7.2-rc2#n145
* https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/=
Documentation/process/stable-kernel-rules.rst?h=3Dv7.2-rc2#n34



* Would you like to complete the exception handling by using another goto =
chain?

* How do you think about to increase the application of scope-based resour=
ce management?


Regards,
Markus

